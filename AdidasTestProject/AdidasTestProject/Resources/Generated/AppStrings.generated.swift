// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum AppLocale {
    // MARK: - Constants

    public enum Constants {
        public static let defaultTable: String = "Localizable"
    }

    public static var currentLanguageCode: String = "en"


  public enum General {
      /// Offline mode
      public static let offlinemode: String = AppLocale.tr("Localize", "general.offlinemode")
      /// Rating: 
      public static let rating: String = AppLocale.tr("Localize", "general.rating")
      /// Success!
      public static let success: String = AppLocale.tr("Localize", "general.success")
  }

  public enum ProductDetail {
      /// Send Review
      public static let buttonTitle: String = AppLocale.tr("Localize", "productDetail.buttonTitle")
      /// Feedbacks:
      public static let feedbackList: String = AppLocale.tr("Localize", "productDetail.feedbackList")
      /// Give us feedback
      public static let giveFeedback: String = AppLocale.tr("Localize", "productDetail.giveFeedback")
      /// Feedback text
      public static let placholderReview: String = AppLocale.tr("Localize", "productDetail.placholderReview")
      /// Product Detail
      public static let title: String = AppLocale.tr("Localize", "productDetail.title")
  }

  public enum ProductList {
      /// Product List
      public static let title: String = AppLocale.tr("Localize", "productList.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

public extension AppLocale {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        // swiftlint:disable:next nslocalizedstring_key
        let path = Bundle(for: BundleToken.self).path(forResource: AppLocale.currentLanguageCode, ofType: "lproj")
        let bundle = Bundle(path: path!) ?? Bundle(for: BundleToken.self)
        let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
    static func tr(_ key: String) -> String {
        tr(Constants.defaultTable, key)
    }
}

private final class BundleToken {}
