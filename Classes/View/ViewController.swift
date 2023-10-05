//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLatestCurrencyData()
    }


    private func loadLatestCurrencyData() {
        
        viewModel.loadLatestCurrencyRates(urlStr: Constants.latestCurrencyRatesURL) { (latestCurrencyRates) in
            print("Latest Currency Rates = \(latestCurrencyRates)")
        }
    }
}

