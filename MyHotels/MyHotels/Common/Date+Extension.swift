//
//  Date+Extension.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 22/07/21.
//

import UIKit

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
