//
//  RealmManager.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Foundation
import RealmSwift

enum DBModels { }

protocol RealmDataStore {
    associatedtype T: Object

    static var realm: RealmManager<T> { get }
}

/**
 Realm manager class that reduces the boiler plate needed when creating a realm transaction.
 createOrUpdate, and Delete uses background thread

 - warning: This class assumes that every existing model being passed has a primaryKey set to it
 */
public class RealmManager<T> {
    public typealias Completion = ((_ error: Error?) -> Void)?

    var realm: Realm?

    var background: RealmThread?

    private var token: NotificationToken?
    private var configuration: Realm.Configuration?
    private var fileUrl: URL?

    init(configuration: Realm.Configuration?, fileUrl: URL?) {
        self.configuration = configuration
        self.fileUrl = fileUrl

        background = RealmThread(start: true, queue: nil)
        background?.enqueue { [weak self] in
            guard let self = self else { return }

            self.realm = self.createRealm(from: configuration, fileUrl: fileUrl)
        }
    }

    convenience init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0

        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        ) { _, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            switch oldSchemaVersion {
                case 0:
                    break
                default:
                    break
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    //                self.zeroToOne(migration)
            }
        }

        self.init(configuration: config, fileUrl: nil)
    }

    private func createRealm(from configuration: Realm.Configuration?, fileUrl: URL?) -> Realm {
        do {
            if let config = configuration {
                return try Realm(configuration: config)
            } else if let fileUrl = fileUrl {
                return try Realm(fileURL: fileUrl)
            } else {
                return try Realm()
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

extension RealmManager {
    private func addOrUpdateWithRealm<Q: Collection>(realm: Realm, object: Q, completion: Completion = nil) where Q.Element == Object {
        do {
            try realm.write {
                realm.add(object, update: .modified)

                DispatchQueue.main.async {
                    completion?(nil)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                completion?(error)
            }
        }
    }

    private func addOrUpdateWithRealm<T: Object>(realm: Realm, object: T, completion: Completion = nil) {
        do {
            try realm.write {
                realm.add(
                    object,
                    update: .modified
                )

                DispatchQueue.main.async {
                    completion?(nil)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                completion?(error)
            }
        }
    }

    @discardableResult private func write(rlmObject: Realm, writeBlock:() -> Void) -> Error? {
        do {
            // try to do a realm transaction
            try rlmObject.write {
                writeBlock()
            }
        } catch let error {
            // catch and return the error if occurs
            return error
        }
        // no error
        return nil
    }

    private func fetch<Q: Object>(condition: String?, completion: @escaping (_ result: Results<Q>) -> Void) {
        let realm = createRealm(from: configuration, fileUrl: fileUrl)
        debugPrint(realm.refresh())

        // All object inside the model passed.
        var objects = realm.objects(Q.self)

        if let cond = condition {
            // filters the result if condition exists
            objects = objects.filter(cond)
        }

        completion(objects)
    }
}

extension RealmManager where T: Collection, T.Element == Object {
    /// Add or Update an object to existing Model
    ///
    /// Accept any object that conforms to Collection Protocol,
    /// Takes a closure as escaping
    /// parameter.
    ///
    /// - Parameter object: [Object] to be saved.
    /// - Parameter completion: Closure called after
    ///   realm transaction
    /// - Parameter error: an optional value containing error
    public func addOrUpdate(object: T, completion: Completion) {
        background?.enqueue { [weak self] in
            guard let self = self else { return }

            guard let realm = self.realm else { return }

            self.addOrUpdateWithRealm(realm: realm, object: object, completion: completion)
        }
    }

    // MARK: - File Private
    private func delete(condition: String?, objects: T, completion: Completion = nil) {
        let group = DispatchGroup()
        var error: Error?

        background?.enqueue { [weak self] in
            group.enter()

            guard let self = self else { return }

            guard let realm = self.realm else { return }

            error = self.write(rlmObject: realm) {
                realm.delete(objects)
                group.leave()
            }
        }

        group.wait()
        DispatchQueue.main.async {
            completion?(error)
        }
    }
}

extension RealmManager where T: Object {
    public func write(writeBlock: @escaping () -> Void) {
        background?.enqueue { [weak self] in
            guard let self = self else { return }

            guard let realm = self.realm else { return }

            self.write(rlmObject: realm, writeBlock: writeBlock)
        }
    }

    /// Add or Update an object to existing Model
    ///
    /// Accept any object that is a subclass of Object or RealmObject,
    /// Takes a closure as escaping
    /// parameter.
    ///
    /// - Parameter object: Object to be saved.
    /// - Parameter completion: Closure called after
    ///   realm transaction
    /// - Parameter error: an optional value containing error
    public func addOrUpdate(configuration: Realm.Configuration? = nil, object: T, completion: Completion = nil) {
        background?.enqueue {[weak self] in
            guard let self = self else { return }

            guard let realm = self.realm else { return }

            self.addOrUpdateWithRealm(realm: realm, object: object, completion: completion)
        }
    }

    public func addOrUpdate(configuration: Realm.Configuration? = nil, object: [T], completion: Completion = nil) {
        background?.enqueue {[weak self] in
            guard let self = self else { return }

            guard let realm = self.realm else { return }

            self.addOrUpdateWithRealm(realm: realm, object: object, completion: completion)
        }
    }

    /// Fetches object from existing model
    ///
    ///
    /// - Parameter type: Type representing the object to be fetch, must be
    /// subclass of Object
    /// - Parameter condition: Predicate to be used when fetching
    ///   data from the Realm database (Optional: String)
    /// - Parameter completion: Closure called after the
    ///   realm transaction
    /// - Parameter result: An Array of Object as result from
    ///   the fetching
    public func fetchWith(condition: String? = nil, completion: @escaping (_ result: Results<T>) -> Void) {
        fetch(condition: condition, completion: completion)
    }

    /// Deletes an object from the existing model
    ///
    ///
    /// - Parameter configuration: Realm Configuration to be used
    /// - Parameter model: A string of any class NAME that inherits from 'Object' class
    /// - Parameter condition: Predicate to be used when deleting
    ///   data from the Realm database (Optional: String)
    /// - Parameter completion: Closure called after the
    ///   realm transaction
    /// - Parameter error: an optional value containing error
    public func deleteWithObject(_ object: T?, condition: String, completion: Completion = nil) {
        background?.enqueue { [weak self] in
            guard let self = self else { return }

            self.delete(object: object, condition: condition, completion: completion)
        }
    }

    private func delete(object: T?, condition: String?, completion: Completion = nil) {
        guard let realm = realm else { return }

        let group = DispatchGroup()
        var error: Error?

        background?.enqueue { [weak self] in
            group.enter()
            guard let self = self else { return }

            if object == nil {
                var fetched = realm.objects(T.self)

                if let cond = condition {
                    // filters the result if condition exists
                    fetched = fetched.filter(cond)
                }

                error = self.write(rlmObject: realm) {
                    realm.delete(fetched)
                    group.leave()
                }
            } else {
                if let object = object {
                    error = self.write(rlmObject: realm) {
                        realm.delete(object)
                        group.leave()
                    }
                }
            }
        }

        group.wait()
        DispatchQueue.main.async {
            completion?(error)
        }
    }
}
