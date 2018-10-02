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
        allObjects(type: ConfigurationDB.self) { [weak self] (objects: [ConfigurationDB]) in
            let objConfig = ConfigurationRepresentable(configuration: objects.first)
            DispatchQueue.main.async {
                let urlBase = objConfig.getBaseUrl().value
                let listSizes = objConfig.getPosterSizes().value
                let sizeImage = listSizes.count > 0 ? listSizes[1] : ""
                let url = URL(string: "\(String(describing: urlBase))\(sizeImage)\(subPath)")
                self?.kf.setImage(with: url, placeholder: R.image.posterPlaceholder())
            }
        }
    }
    
    func addBackdropImage(subPath: String){
        allObjects(type: ConfigurationDB.self) { [weak self] (objects: [ConfigurationDB]) in
            let objConfig = ConfigurationRepresentable(configuration: objects.first)
            DispatchQueue.main.async {
                let urlBase = objConfig.getBaseUrl().value
                let listSizes = objConfig.getBackdropSizes().value
                let sizeImage = listSizes.count > 0 ? listSizes[1] : ""
                let url = URL(string: "\(String(describing: urlBase))\(sizeImage)\(subPath)")
                self?.kf.setImage(with: url, placeholder: R.image.backdropPlaceholder())
            }
        }
    }
}
