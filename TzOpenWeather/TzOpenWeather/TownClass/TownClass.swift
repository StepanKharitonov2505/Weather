//
//  TownClass.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 14.01.2022.
//

import Foundation

class TownClass {
    var townName: String
    static var townArray: [TownClass] = []
    
    init(townName: String) {
        self.townName = townName
    }
}
