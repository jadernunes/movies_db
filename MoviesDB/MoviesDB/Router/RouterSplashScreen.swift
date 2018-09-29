//
//  RouterSplashScreen.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

final class RouterSplashScreen {
    
    enum ScreenName {
        case home
    }
    
    func navigate(screen: ScreenName){
        switch screen {
        case .home:
            openHome()
            break
        }
    }
    
    private func openHome(){
        guard let window = UIApplication.shared.delegate?.window else { return }
        let viewController = R.storyboard.general.homeTabBarController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
