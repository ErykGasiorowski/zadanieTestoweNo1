//
//  CurrencyCViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyCViewController: UIViewController {

    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .insetGrouped)
            
            tableView.backgroundColor = .systemBackground
            tableView.register(CurrencyCTableViewCell.self, forCellReuseIdentifier: "CurrencyCTableViewCell")
            tableView.rowHeight = 100

        return tableView
    }()
    
    var resultsC: [TableCElement] = [TableCElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height)
    }
}

extension CurrencyCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
