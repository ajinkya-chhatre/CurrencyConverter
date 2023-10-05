//
//  CurrencyRates+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//
//

import Foundation
import CoreData


extension CurrencyRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyRates> {
        return NSFetchRequest<CurrencyRates>(entityName: "CurrencyRates")
    }

    @NSManaged public var baseCurrency: String?
    @NSManaged public var currencyRates: Data?
}

extension CurrencyRates : Identifiable {

}
