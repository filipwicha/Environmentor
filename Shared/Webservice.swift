//
//  WebService.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//

import Foundation

class Webservice {
    
    func getData(completion: @escaping (Weather?) -> ()) {
        
        guard let url = URL(string: "https://homeofficer.herokuapp.com/demo/data") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
            DispatchQueue.main.async {
                completion(weather)
            }
            
        }.resume()
    }
}
