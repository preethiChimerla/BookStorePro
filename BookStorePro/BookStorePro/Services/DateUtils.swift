//
//  DateUtils.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/3/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import Foundation

class DateUtils {
    
    static func convertToReadableFormat(_ dateToFormat: String?) -> String {
        let dateFormatter = DateFormatter()
        if dateToFormat == nil {
            return ""
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date: Date? = dateFormatter.date(from: dateToFormat!)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
        return dateFormatter.string(from: date!)
    }
}


