//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var resultsA: [TableABElement] = [TableABElement]()
    var currencyA: [Rate] = [Rate]()
    var resultsC: [TableCElement] = [TableCElement]()
    
    private let abHeader = TableABHeaderView()
    private let cHeader = TableCHeaderView()
    
    let items = ["Table A", "Table B", "Table C"]
    
    var headerView: UIView = {
        let headerView = UIView()
        //headerView.layer.cornerRadius = 9
        headerView.layer.borderWidth = 1
        headerView.layer.masksToBounds = false
        headerView.layer.borderColor = UIColor.systemBlue.cgColor
        headerView.tintColor = UIColor.label
        headerView.backgroundColor = .secondarySystemBackground
        headerView.clipsToBounds = true
        
        return headerView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 9
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor = UIColor.systemBlue.cgColor
        control.tintColor = UIColor.label
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        return control
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Refresh", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = UIColor.label
        button.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        return button
    }()
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("A")
            tableType = "A"
            getTableABData()
            updateHeaderView()
        case 1:
            print("B")
            tableType = "B"
            getTableABData()
            updateHeaderView()
        case 2:
            tableType = "C"
            getTableCData()
            updateHeaderView()
            print("C")
        default:
            tableType = "A"
            getTableABData()
            updateHeaderView()
            print("No table selected")
        }
    }
    
    public var tableType: String?
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .grouped)
        
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 50
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
        tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(segmentedControl)
        view.addSubview(button)
        view.addSubview(headerView)
        tableType = "A"
        getTableABData()
        updateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedControl.frame = CGRect(x: 0, y: view.safeAreaInsets.top+30, width: view.width, height: 40)
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+150, width: view.width, height: view.height-150)
        button.frame = CGRect(x: view.width/2.5, y: segmentedControl.bottom+10, width: 80, height: 40)
        headerView.frame = CGRect(x: 0, y: button.bottom+10, width: view.width, height: 60)
        abHeader.frame = CGRect(x: 2, y: button.bottom+10, width: view.width-2, height: 58)
        cHeader.frame = CGRect(x: 2, y: button.bottom+10, width: view.width-2, height: 58)
    }
    
    private func getTableABData() {
        APICaller.shared.getDataForTableA(for: tableType!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultsA = model
                    self.tableView.reloadData()
                //print(result)
                
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getTableCData() {
        APICaller.shared.getDataForTableC(for: tableType!) { result in
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
    
    @objc func didTapRefresh() {
        createSpinnerView()
        tableView.reloadData()
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // Wait for two seconds - work in progress simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    private func updateHeaderView() {
        view.addSubview(abHeader)
        view.addSubview(cHeader)
        switch segmentedControl.selectedSegmentIndex {

        case 0:
            abHeader.isHidden = false
            cHeader.isHidden = true
        case 1:
            abHeader.isHidden = false
            cHeader.isHidden = true
        case 2:
            abHeader.isHidden = true
            cHeader.isHidden = false
        default:
            abHeader.isHidden = false
            cHeader.isHidden = true
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            return resultsA.first?.rates.count ?? 0
        case 1:
            return resultsA.first?.rates.count ?? 0
        case 2:
            return resultsC.first?.rates.count ?? 1
        default:
            return resultsA.first?.rates.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            let model = resultsA.first?.rates[indexPath.row]
            let dateModel = resultsA
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableABTableViewCell", for: indexPath) as? TableABTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: TableABTableViewCellViewModel(
                            effectiveDate: dateModel.first?.effectiveDate ?? "",
                            currency: model?.currency ?? "",
                            code: model?.code ?? "",
                            mid: model?.mid))
            
            return cell
            
        case 1:
            let model = resultsA.first?.rates[indexPath.row]
            let dateModel = resultsA
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableABTableViewCell", for: indexPath) as? TableABTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: TableABTableViewCellViewModel(
                            effectiveDate: dateModel.first?.effectiveDate ?? "",
                            currency: model?.currency ?? "",
                            code: model?.code ?? "",
                            mid: model?.mid))
            
            return cell
            
        case 2:
            let model = resultsC.first?.rates[indexPath.row]
            let dateModel = resultsC
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCTableViewCell", for: indexPath) as? TableCTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: TableCTableViewCellViewModel(
                            tradingDate: dateModel.first?.tradingDate ?? "",
                            currency: model?.currency ?? "",
                            code: model?.code ?? "",
                            ask: model?.ask,
                            bid: model?.bid))
            
            return cell
            
        default:
            let model = resultsA.first?.rates[indexPath.row]
            let dateModel = resultsA
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableABTableViewCell", for: indexPath) as? TableABTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: TableABTableViewCellViewModel(
                            effectiveDate: dateModel.first?.effectiveDate ?? "",
                            currency: model?.currency ?? "",
                            code: model?.code ?? "",
                            mid: model?.mid))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            let tableA = resultsA.first?.rates[indexPath.row]
            let rootVC = CurrencyAViewController(currency: tableA, table: resultsA.first?.table ?? "")
            let navVC = UINavigationController(rootViewController: rootVC)
            
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.tintColor = .label
            present(navVC, animated: true)
            
        case 1:
            let tableA = resultsA.first?.rates[indexPath.row]
            let rootVC = CurrencyAViewController(currency: tableA, table: resultsA.first?.table ?? "")
            let navVC = UINavigationController(rootViewController: rootVC)
            
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.tintColor = .label
            present(navVC, animated: true)
            
        case 2:
            let tableC = resultsC.first?.rates[indexPath.row]
            let rootVC = CurrencyCViewController(currency: tableC, table: resultsC.first?.table ?? "")
            let navVC = UINavigationController(rootViewController: rootVC)
            
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.tintColor = .label
            present(navVC, animated: true)
            
        default:
            let tableA = resultsA.first?.rates[indexPath.row]
            let rootVC = CurrencyAViewController(currency: tableA, table: resultsA.first?.table ?? "")
            let navVC = UINavigationController(rootViewController: rootVC)
            
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.tintColor = .label
            present(navVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
