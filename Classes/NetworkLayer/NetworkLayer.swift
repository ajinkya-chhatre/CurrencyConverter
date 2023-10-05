//
//  NetworkLayer.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import Foundation

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url ) { data, _, _ in
            guard let data = data else { return completion(nil) }
            completion(resource.parse(data))
        }.resume()
    }
}



