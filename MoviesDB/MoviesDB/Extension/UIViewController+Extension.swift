//
//  UIViewController+Extension.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorMesssage(mesage: String) {
        if let superFrame =  UIApplication.shared.keyWindow?.frame {
            let errorView: UIView = UIView(frame: CGRect(x: superFrame.origin.x, y: superFrame.origin.y, width: superFrame.height, height: 95))
            errorView.backgroundColor = .black
            
            let labelMessage = UILabel(frame: CGRect(x: errorView.frame.origin.x + 20,
                                                     y: errorView.frame.origin.y,
                                                     width: errorView.frame.width,
                                                     height: errorView.frame.height))
            
            labelMessage.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            labelMessage.text = mesage
            labelMessage.textColor = .white
            
            errorView.frame.origin.y = superFrame.origin.y - errorView.frame.height
            errorView.addSubview(labelMessage)
            
            UIView.animate(withDuration: 0.2, animations: {
                
                errorView.frame.origin.y = superFrame.origin.y
                UIApplication.shared.keyWindow?.addSubview(errorView)
                
            }, completion: { (finish) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.animate(withDuration: 0.2, animations: {
                        errorView.frame.origin.y = superFrame.origin.y - errorView.frame.height
                    }, completion: { (finish) in
                        self.removeErrorMessage(errorView: errorView)
                    })
                }
            })
        }
    }
    
    private func removeErrorMessage(errorView: UIView) {
        errorView.removeFromSuperview()
    }
}
