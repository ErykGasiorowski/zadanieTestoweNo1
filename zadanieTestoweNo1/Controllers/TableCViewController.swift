//
//  TableCViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 20/06/2021.
//

import UIKit

class TableCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var resultsC: [TableCElement] = [TableCElement]()

    let tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .insetGrouped)
        
            tableView.backgroundColor = .systemBackground
            tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
            tableView.rowHeight = 100

            return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        getTableCData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height)
    }
    
    private func getTableCData() {
        APICaller.shared.getDataForTableC { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultsC = model
                    self.tableView.reloadData()
                    //print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - TableView funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsC.first?.rates.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = resultsC.first?.rates[indexPath.row]
        let dateModel = resultsC

        let cell: TableCTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "TableCTableViewCell", for: indexPath) as! TableCTableViewCell
        
        cell.configure(with: TableCTableViewCellViewModel(
                        tradingDate: dateModel.first?.tradingDate ?? "",
                        currency: model?.currency ?? "",
                        code: model?.code ?? "",
                        ask: model?.ask,
                        bid: model?.bid))
        
        return cell
    }
}
