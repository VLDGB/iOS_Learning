//
//  DateUtil.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 02.04.2023.
//

import Foundation.NSDateFormatter
import Foundation.NSDate

struct DateUtil {
    
    static let shared = DateUtil()

    var dateFormatter: DateFormatter { get { _dateFormatter } }
    
    private let _dateFormatter = DateFormatter()
    
    private init() { setDateFormatter() }
    
    func string(from date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        _dateFormatter.dateStyle = dateStyle
        _dateFormatter.timeStyle = timeStyle
        return _dateFormatter.string(from: date)
    }
    
    // sets _dateFormatter to ISO 8601 standard
    private func setDateFormatter() {
        _dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        _dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        _dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
}
