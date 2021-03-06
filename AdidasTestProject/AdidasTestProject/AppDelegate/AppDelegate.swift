//
//  AppDelegate.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import UIKit
import Macaroni
import IQKeyboardManagerSwift
import MetricKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if PROD
        Container.policy = .singleton(
            RestContainerFactory(
                baseProductURL: ApiURLsPath.baseProductUrl.rawValue,
                baseReviewURL: ApiURLsPath.baseReviewUrl.rawValue
            ).build()
        )
        #elseif STAGE
        Container.policy = .singleton(
            RestContainerFactory(
                baseProductURL: ApiURLsPath.baseProductUrl.rawValue,
                baseReviewURL: ApiURLsPath.baseReviewUrl.rawValue
            ).build()
        )
        #else
        Container.policy = .singleton(MockContainerFactory().build())
        #endif

        IQKeyboardManager.shared.enable = true
        MXMetricManager.shared.add(self)

        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        MXMetricManager.shared.remove(self)
    }
}

extension AppDelegate: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        guard let firstPayload = payloads.first else { return }

        debugPrint(firstPayload)
    }

    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        guard let firstPayload = payloads.first else { return }

        debugPrint(firstPayload.dictionaryRepresentation())
    }
}

