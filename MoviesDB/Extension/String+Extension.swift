//
//  String+Extension.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

extension String {
    func dateToShow() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        dateFormatterGet.date(from: self)
        guard let date = dateFormatterGet.date(from: self) else {
            return self
        }
        
        let newDate = dateFormatterPrint.string(from: date)
        return newDate
    }
}
