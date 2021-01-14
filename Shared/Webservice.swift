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
    
    func getPercent(completion: @escaping (Percent?) -> ()) {
        
        guard let url = URL(string: "https://homeofficer.herokuapp.com/demo/percent") else {
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
            
            let percent = try? JSONDecoder().decode(Percent.self, from: data)
            DispatchQueue.main.async {
                completion(percent)
            }
            
        }.resume()
    }
    
    
    func setPercent(percent: Percent, completion: @escaping (Result<String, Error>) -> ()) {
            
            guard let url = URL(string: "https://homeofficer.herokuapp.com/demo/percent") else {
                fatalError("Invalid URL")
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(percent)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let _ = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                        print("Error getting data" + error!.localizedDescription )
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success("Value set to " + String(percent.value)))
                }
            }.resume()
        }
}
