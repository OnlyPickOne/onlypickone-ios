//
//  String+.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/16.
//

import Foundation

extension String {
    func toLastTimeString() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        format.timeZone = TimeZone(abbreviation: "UTC")
        guard let startTime = format.date(from: self), let endTime = format.date(from: format.string(from: Date())) else {return ""}
        return Int(endTime.timeIntervalSince(startTime)).toLastTimeString()
    }
}
