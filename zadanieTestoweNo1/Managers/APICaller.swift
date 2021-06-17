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
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getDataForTableA(completion: @escaping (Result<[TableABElement], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/tables/A"),
            type: .GET
        ) { baseRequest in
            
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([TableABElement].self, from: data)
                        
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                         
                    //print(result)
                    completion(.success(result))
                }
                catch {
                print(error)
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
    
    public func getDataForTableB(completion: @escaping (Result<[TableABElement], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/tables/B"),
            type: .GET
        ) { baseRequest in
            
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([TableABElement].self, from: data)
                        
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                         
                    //print(result)
                    completion(.success(result))
                }
                catch {
                print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getDataForTableC(completion: @escaping(Result<[TableCElement], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/tables/C"),
            type: .GET
        ) { baseRequest in
            
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([TableCElement].self, from: data)
                        
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                print(error)
                    completion(.failure(error))
                    
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

