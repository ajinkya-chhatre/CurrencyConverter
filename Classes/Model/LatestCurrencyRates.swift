//
//  LatestCurrencyRates.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import Foundation

struct LatestCurrencyRates: Codable {
    var baseCurrency: String?
    var currencyRates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case baseCurrency     = "base"
        case currencyRates    = "rates"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseCurrency = try container.decodeIfPresent(String.self, forKey: .baseCurrency)
        currencyRates = try container.decodeIfPresent([String: Double].self, forKey: .currencyRates)
    }
    
    // Convenience initializer
    init(baseCurrency: String?, currencyRates: [String: Double]?) {
        self.baseCurrency = baseCurrency
        self.currencyRates = currencyRates
    }
}
