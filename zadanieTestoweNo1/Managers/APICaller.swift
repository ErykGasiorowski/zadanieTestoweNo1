//
//  APICaller.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseURL = "https://api.nbp.pl/api/exchangerates"
    }
    
    public func getData() {
        createRequest(
            with: URL(string: Constants.baseURL + "/tables/A"),
            type: .GET
        ) { baseRequest in
            
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    print("error")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([TableAElement].self, from: data)
                        
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                         
                    print(result)
                    
                    
                }
                catch {
                print(error)
                    
                }
            }
            task.resume()
        }
    }
    
    func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void) {
        
        guard let apiURL = url else {
            return
        }
        
            var request = URLRequest(url: apiURL)
            request.httpMethod = type.rawValue
            completion(request)
    }
    
    enum HTTPMethod: String {
        case GET
    }
}

