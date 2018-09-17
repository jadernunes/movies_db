//
//  UIView+Extension.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func startLoader(){
        let viewLoading = UIView(frame: self.frame)
        viewLoading.tag = tagViewLoading
        viewLoading.backgroundColor = UIColor.black
        viewLoading.alpha = 0.4
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loader.startAnimating()
        loader.center = viewLoading.center
        viewLoading.addSubview(loader)
        self.addSubview(viewLoading)
        self.bringSubview(toFront: viewLoading)
    }
    
    func stopLoader(){
        self.subviews.forEach { (view) in
            if view.tag == tagViewLoading {
                view.removeFromSuperview()
                return
            }
        }
    }
}
