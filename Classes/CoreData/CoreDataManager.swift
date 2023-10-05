//
//  CoreDataManager.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    // Create a shared Instance
    static let shared = CoreDataManager()


    // MARK: - Core Data stack
    
    // Get the managed Object Context
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveCurrencyDataInDatabase(latestCurrencyRates: LatestCurrencyRates) {
        createEntityFrom(latestCurrencyRates: latestCurrencyRates)
        saveData()
    }
    
    private func createEntityFrom(latestCurrencyRates: LatestCurrencyRates) {
        guard let baseCurrency = latestCurrencyRates.baseCurrency, let rates = latestCurrencyRates.currencyRates else {
            return
        }

        // Convert to core data entity
        let currencyRatesEntity = CurrencyRates(context: self.managedObjectContext)
        currencyRatesEntity.baseCurrency = baseCurrency
        let ratesData = try! JSONEncoder().encode(rates)
        currencyRatesEntity.currencyRates = ratesData
    }
    
    // Save the data in Database
    private func saveData(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Fetch the data from database
    func fetchCurrencyDataFromDatabase() -> LatestCurrencyRates? {
        let fetchRequest: NSFetchRequest<CurrencyRates> = CurrencyRates.fetchRequest()
        
        guard let result = try? managedObjectContext.fetch(fetchRequest) else {
            return nil
        }
        
        if let currencyRates = result.first {
            guard let ratesData = currencyRates.currencyRates, let ratesDictionary = try? JSONDecoder().decode([String: Double].self, from: ratesData) else {
               return nil
            }
            guard let baseCurrency = currencyRates.baseCurrency else {
                return nil
             }
            
            return LatestCurrencyRates(baseCurrency: baseCurrency, currencyRates: ratesDictionary)
        }
        return nil
    }
}
