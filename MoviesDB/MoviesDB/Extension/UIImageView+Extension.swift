//
//  UIImageView+Extension.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func addPosterImage(subPath: String){
        Configuration.allObjects { (objects: [Configuration]) in
            if let objConfig = objects.first {
                let urlBase = objConfig.getBaseUrl().value
                let sizeImage = objConfig.getPosterSizes().value[1]
                let url = URL(string: "\(String(describing: urlBase))\(sizeImage)\(subPath)")
                let image = UIImage(named: "posterPlaceholder")//TODO: Insert image in project
                self.kf.setImage(with: url, placeholder: image)
            }
        }
    }
    
    func addBackdropImage(subPath: String){
        Configuration.allObjects { (objects: [Configuration]) in
            if let objConfig = objects.first {
                let urlBase = objConfig.getBaseUrl().value
                let sizeImage = objConfig.getBackdropSizes().value[1]
                let url = URL(string: "\(String(describing: urlBase))\(sizeImage)\(subPath)")
                let image = UIImage(named: "backdropPlaceholder")//TODO: Insert image in project
                self.kf.setImage(with: url, placeholder: image)
            }
        }
    }
}
