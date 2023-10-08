//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 04/10/23.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: AnyObject]

protocol CurrencyDataRefreshDelegate: AnyObject {
    func currencyDataRefreshed(_ latestCurrencyRates: LatestCurrencyRates)
}


class ViewModel {
    
    var dataRefreshTimer: Timer?
    var webService = Webservice()
    weak var currencyDataRefreshDelegate: CurrencyDataRefreshDelegate?
    
    
    func fetchLatestCurrencyRates(completion: @escaping (LatestCurrencyRates?) -> ()) {
        // first check if data exists locally
        if let latestCurrencyRates = CoreDataManager.shared.fetchCurrencyDataFromDatabase() {
            completion(latestCurrencyRates)
        } else {
            loadLatestCurrencyRates(completion: completion)
        }
    }
    
    func loadLatestCurrencyRates(completion: @escaping (LatestCurrencyRates?) -> ()) {
        // Create the latest currency resource
        guard let latestCurrencyResource = createLatestCurrencyResource(urlStr: Constants.latestCurrencyRatesURL) else {
            completion(nil)
            return
        }
        
        // Load the latest currency resource
        webService.load(resource: latestCurrencyResource) { (latestCurrencyRates) in
            guard let latestCurrencyRates = latestCurrencyRates else {
                completion(nil)
                return
            }
            // Save the latestcurrency rates in database
            CoreDataManager.shared.saveCurrencyDataInDatabase(latestCurrencyRates: latestCurrencyRates)
            completion(latestCurrencyRates)
        }
    }
    
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
    
    // Function to start the timer
    func startTimerToRefreshData() {
        // Create a timer that repeats every 30 minutes (1800 seconds)
        dataRefreshTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    
    @objc func timerAction() {
        loadLatestCurrencyRates(completion: { (latestCurrencyRates) in
            guard let latestRates = latestCurrencyRates else { return }
            self.currencyDataRefreshDelegate?.currencyDataRefreshed(latestRates)
        })
    }
}
