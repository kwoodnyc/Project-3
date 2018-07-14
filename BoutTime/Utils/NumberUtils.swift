//
//  NumberUtils.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/2018.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

class NumberUtils {
    static func format(num: Int) -> String {
        if num == 60 {
            return "1:00"
        } else if num < 60 && num >= 10 {
            return "0:\(num)"
        } else {
            return "0:0\(num)"
        }
    }
}
