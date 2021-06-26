//
//  CurrencyAViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyAViewController: UIViewController {
    
    
    // sprawdzić czy działa jak zacznie się wyświetlać ten widok po kliknięciu w tableview w home screenie
    let date1: UITextField = {
        
        let date1 = UITextField()
        
        date1.translatesAutoresizingMaskIntoConstraints = false
        date1.placeholder = "Enter Start Date here..."
        date1.font = UIFont.systemFont(ofSize: 12)
        date1.borderStyle = .bezel
       
        return date1
    }()
    // pole tekstowe do Start Date
    // end of comment
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .insetGrouped)
            
            tableView.backgroundColor = .systemBackground
            tableView.register(CurrencyABTableViewCell.self, forCellReuseIdentifier: "CurrencyABTableViewCell")
            tableView.rowHeight = 100

        return tableView
    }()
    
    var resultsA: [TableABElement] = [TableABElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .red
        //getCurrencyAData()
    }
    
    override func viewDidLayoutSubviews() {
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height)
    }
    
//    private func getCurrencyAData() {
//        APICaller.shared.getCurrencyAData { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let model):
//                    self.resultsA = model
//                    self.tableView.reloadData()
//                    //print(result)
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}


extension CurrencyAViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
