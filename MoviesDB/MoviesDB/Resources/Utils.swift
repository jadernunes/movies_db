//
//  Utils.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

final class Utils {
    
    /// Get the visible ViewController
    ///
    /// - Returns: current ViewController
    class func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.delegate?.window else { return nil }
        if let rootViewController: UIViewController  = window?.rootViewController {
            return getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    /// Search for visible ViewController based on ViewController received
    ///
    /// - Parameter vc: ViewControler to search the visible ViewController
    /// - Returns: Visible ViewController
    private class func getVisibleViewControllerFrom(vc:UIViewController?) -> UIViewController? {
        if let navigationController = vc as? UINavigationController {
            return getVisibleViewControllerFrom(vc: navigationController.visibleViewController)
        } else {
            if let presentedViewController = vc?.presentedViewController {
                return getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}
