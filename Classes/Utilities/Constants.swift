//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import Foundation

let appID = "bb3d05b47f33449ba32f25b19ce6a9fb"

struct Constants {
    
    static var latestCurrencyRatesURL: String {
        return "https://openexchangerates.org/api/latest.json?app_id=" + appID
    }
    
    static let convertRatesURL = "https://openexchangerates.org/api/convert"
}
