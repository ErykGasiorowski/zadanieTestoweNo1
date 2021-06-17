//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //weak var delegate: ViewControllerDelegate?
    
    var resultsAB: [TableABElement] = [TableABElement]()
    
    var resultsC: [TableCElement] = [TableCElement]()

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .insetGrouped)
            tableView.backgroundColor = .systemBackground
            //tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
        tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
        tableView.rowHeight = 100

            return tableView
        }()
    
    private let tableAButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let tableBButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let tableCButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table C", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

//    private let spinner: UIActivityIndicatorView = {
//       let spinner = UIActivityIndicatorView()
//        spinner.tintColor = .label
//        spinner.hidesWhenStopped = true
//        return spinner
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        //view.addSubview(spinner)
        view.addSubview(tableAButton)
        tableAButton.addTarget(self, action: #selector(didTapAButton), for: .touchUpInside)
        view.addSubview(tableBButton)
        tableBButton.addTarget(self, action: #selector(didTapBButton), for: .touchUpInside)
        view.addSubview(tableCButton)
        tableCButton.addTarget(self, action: #selector(didTapCButton), for: .touchUpInside)
        //tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
        tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        
//        self.tableView.reloadData()
        
        }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableAButton.frame = CGRect(
            x: 25,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
        tableBButton.frame = CGRect(
            x: tableAButton.right+20,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
        tableCButton.frame = CGRect(
            x: tableBButton.right+20,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height)
        
    
    }
    
    @objc func didTapAButton() {
        getTableAData()
        tableView.isHidden = false
        
    }
    
    @objc func didTapBButton() {
        getTableBData()
        tableView.isHidden = false
        
    }
    
    @objc func didTapCButton() {
        getTableCData()
        tableView.isHidden = false
        
    }
    
    
    
    private func getTableAData() {
        APICaller.shared.getDataForTableA { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultsAB = model
                    self.tableView.reloadData()
                    //print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getTableBData() {
        APICaller.shared.getDataForTableB { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultsAB = model
                    self.tableView.reloadData()
                    //print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Results count: \(results.first?.rates.count)")
        return resultsAB.first?.rates.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if tableAButton.isSelected || tableBButton.isSelected {
//
//        let model = resultsAB.first?.rates[indexPath.row]
//        let dateModel = resultsAB
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableABTableViewCell", for: indexPath) as! TableABTableViewCell
//
//        cell.configure(with: TableABTableViewCellViewModel(
//                        effectiveDate: dateModel.first?.effectiveDate ?? "",
//                        currency: model?.currency ?? "",
//                        code: model?.code ?? "",
//                        mid: model?.mid))
//            return cell
//        } else if tableCButton.isSelected {
            let model = resultsC.first?.rates[indexPath.row]
                //resultsAB.first?.rates[indexPath.row]
            let dateModel = resultsC
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCTableViewCell", for: indexPath) as! TableCTableViewCell
            
            cell.configure(with: TableCTableViewCellViewModel(
                            tradingDate: dateModel.first?.tradingDate ?? "",
                            currency: model?.currency ?? "",
                            code: model?.code ?? "",
                            ask: model?.ask,
                            bid: model?.bid))
//                            effectiveDate: dateModel.first?.tradingDate ?? "",
//                            currency: model?.currency ?? "",
//                            code: model?.code ?? "",
//                            mid: model?.mid))
            
            return cell
//        } else {
//            return UITableViewCell()
//        }

        
//
//        //cell.selectionStyle = .none
//
       
    }
    
    
    
}


