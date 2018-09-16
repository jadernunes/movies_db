//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `imageSplashScreen`.
    static let imageSplashScreen = Rswift.ImageResource(bundle: R.hostingBundle, name: "imageSplashScreen")
    
    /// `UIImage(named: "imageSplashScreen", bundle: ..., traitCollection: ...)`
    static func imageSplashScreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.imageSplashScreen, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `SplashScreen`.
    static let splashScreen = _R.storyboard.splashScreen()
    
    /// `UIStoryboard(name: "SplashScreen", bundle: ...)`
    static func splashScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.splashScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 3 localization keys.
    struct localizable {
      /// Base translation: Load data fail
      /// 
      /// Locales: Base
      static let messageLoadDataFail = Rswift.StringResource(key: "messageLoadDataFail", tableName: "Localizable", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Load images fail
      /// 
      /// Locales: Base
      static let messageLoadImagesFail = Rswift.StringResource(key: "messageLoadImagesFail", tableName: "Localizable", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Request fail
      /// 
      /// Locales: Base
      static let messageRequestFail = Rswift.StringResource(key: "messageRequestFail", tableName: "Localizable", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      
      /// Base translation: Load data fail
      /// 
      /// Locales: Base
      static func messageLoadDataFail(_: Void = ()) -> String {
        return NSLocalizedString("messageLoadDataFail", bundle: R.hostingBundle, value: "Load data fail", comment: "")
      }
      
      /// Base translation: Load images fail
      /// 
      /// Locales: Base
      static func messageLoadImagesFail(_: Void = ()) -> String {
        return NSLocalizedString("messageLoadImagesFail", bundle: R.hostingBundle, value: "Load images fail", comment: "")
      }
      
      /// Base translation: Request fail
      /// 
      /// Locales: Base
      static func messageRequestFail(_: Void = ()) -> String {
        return NSLocalizedString("messageRequestFail", bundle: R.hostingBundle, value: "Request fail", comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try splashScreen.validate()
    }
    
    struct splashScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SplashScreenViewController
      
      let bundle = R.hostingBundle
      let name = "SplashScreen"
      let splashScreenViewController = StoryboardViewControllerResource<SplashScreenViewController>(identifier: "SplashScreenViewController")
      
      func splashScreenViewController(_: Void = ()) -> SplashScreenViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: splashScreenViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "imageSplashScreen") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'imageSplashScreen' is used in storyboard 'SplashScreen', but couldn't be loaded.") }
        if _R.storyboard.splashScreen().splashScreenViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'splashScreenViewController' could not be loaded from storyboard 'SplashScreen' as 'SplashScreenViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
