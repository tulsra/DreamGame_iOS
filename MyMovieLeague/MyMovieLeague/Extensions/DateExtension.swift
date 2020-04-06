//
//  DateExtension.swift
//  NLTest
//
//  Created by Tulasi on 01/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import Foundation

extension Date {
    
    
    var displayDate: String {
        get {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMM, yyyy"
            return dateFormatterPrint.string(from: self)
        }
    }
    
    var displayTime: String {
        get {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "hh:mm a"
            return dateFormatterPrint.string(from: self)
        }
    }
    
    func humanDisplayDaateFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        let time = dateFormatter.string(from: self)
        return time    // prints "Today, 5:10 PM"
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
        
}

extension Int {
    var date: Date {
        get {
            return Date(timeIntervalSince1970: TimeInterval(self))
        }
    }
}


extension String {
    
    var date:Date {
        get {
            let formats:[String] = ["yyyy-MM-dd HH:mm:ss",
                                    "yyyy-MM-dd'T'HH:mm:ss",
                                    "yyyy-MM-dd'T'HH:mm:ssZ",
                                    "yyyy-MM-dd'T'HH:mm:ss.SSS",
                                    "yyyy-MM-dd'T'HH:mm",
                                    "E, dd MMM YYYY",
                                    "MMMM dd yyyy",
                                    "yyyy-MM-dd",
                                    "dd MMM yy",
                                    "hh:mm a",
                                    "yyyy-MM-dd hh:mm a",]
            let formatter = DateFormatter()
            var kDate:Date = Date()
            for format in formats {
                formatter.dateFormat = format
                if let aDate = formatter.date(from: self) {
                    kDate = aDate
                    break
                }
            }
            return kDate
        }
    }
    var utcDate:Date {
        get {
            let formats:[String] = ["yyyy-MM-dd HH:mm:ss",
                                    "yyyy-MM-dd'T'HH:mm:ss",
                                    "yyyy-MM-dd'T'HH:mm:ssZ",
                                    "yyyy-MM-dd'T'HH:mm:ss.SSS",
                                    "yyyy-MM-dd'T'HH:mm",
                                    "E, dd MMM YYYY",
                                    "MMMM dd yyyy",
                                    "yyyy-MM-dd",
                                    "dd MMM yy",
                                    "hh:mm a"]
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "UTC")
            var kDate:Date = Date()
            for format in formats {
                formatter.dateFormat = format
                if let aDate = formatter.date(from: self) {
                    kDate = aDate
                    break
                }
            }
            return kDate
        }
    }
}
