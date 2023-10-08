//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import UIKit

class ViewController: UIViewController, CurrencyDataRefreshDelegate {
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLatestCurrencyData()
        viewModel.startTimerToRefreshData()
        viewModel.currencyDataRefreshDelegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.dataRefreshTimer?.invalidate()
    }

    private func loadLatestCurrencyData() {
        
        viewModel.loadLatestCurrencyRates() { (latestCurrencyRates) in
            print("Latest Currency Rates = \(latestCurrencyRates)")
        }
    }
    
    func currencyDataRefreshed(_ latestCurrencyRates: LatestCurrencyRates) {
        // refresh UI as new data has arrived
        print("Data refreshed Latest Currency Rates = \(latestCurrencyRates)")
    }
}

