//
//  DateHelper.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/15/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func toDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: stringDate) as Date?
        
        return(date)
    }
    
}
