//
//  Extensions.swift
//  WeatherAPP
//
//  Created by Тимур Чеберда on 14/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import Foundation


extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
