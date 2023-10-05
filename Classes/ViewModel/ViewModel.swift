//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 04/10/23.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: AnyObject]

class ViewModel {
    
    var webService = Webservice()
    
    private func createLatestCurrencyResource(urlStr: String) -> Resource<LatestCurrencyRates>? {
        guard let url = URL(string: urlStr) else {return nil}
        
        let latestCurrencyResource = Resource<LatestCurrencyRates>(url: url , parse: { data in
            
            guard let latestCurrencyRates = try? JSONDecoder().decode(LatestCurrencyRates.self, from: data) else {
                return nil
            }
            return latestCurrencyRates
        })
        return latestCurrencyResource
    }
    
    
    func loadLatestCurrencyRates(urlStr: String, completion: @escaping (LatestCurrencyRates?) -> ()) {
        
        // first check if data exists locally
        if let latestCurrencyRates = CoreDataManager.shared.fetchCurrencyDataFromDatabase() {
            completion(latestCurrencyRates)
        } else {
            // Create the latest currency resource
            guard let latestCurrencyResource = createLatestCurrencyResource(urlStr: urlStr) else {
                completion(nil)
                return
            }
            
            // Load the latest currency resource
            webService.load(resource: latestCurrencyResource) { (latestCurrencyRates) in
                guard let latestCurrencyRates = latestCurrencyRates else {
                    completion(nil)
                    return
                }
                CoreDataManager.shared.saveCurrencyDataInDatabase(latestCurrencyRates: latestCurrencyRates)
                completion(latestCurrencyRates)
            }
        }
    }
}
