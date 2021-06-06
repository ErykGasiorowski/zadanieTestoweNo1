//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let url = "https://api.nbp.pl/api/exchangerates/tables/A"
        getData()
    }
    
    public func getData() {
        createRequest(
            with: URL(string: "https://api.nbp.pl/api/exchangerates/tables/A"),
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
    
    // MARK: - TableAElement
    struct TableAElement: Codable {
        let table, no, effectiveDate: String
        let rates: [Rate]
    }

    // MARK: - Rate
    struct Rate: Codable {
        let currency, code: String
        let mid: Double
    }
    
    enum HTTPMethod: String {
        case GET
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
    }
}

