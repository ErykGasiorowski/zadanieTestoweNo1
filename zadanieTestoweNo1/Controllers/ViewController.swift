//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableAVC = TableAViewController()
    private let tableBVC = TableBViewController()
    private let tableCVC = TableCViewController()
        
    var resultsA: [TableABElement] = [TableABElement]()
    var currencyA: [Rate] = [Rate]()
    var resultsC: [TableCElement] = [TableCElement]()
    
    private let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    let items = ["Table A", "Table B", "Table C"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control .layer.cornerRadius = 9
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor = UIColor.systemBlue.cgColor
        control.tintColor = UIColor.label
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        return control
    }()

    private let toggleView = TablesToggleView()

//    private let spinner: UIActivityIndicatorView = {
//       let spinner = UIActivityIndicatorView()
//        spinner.tintColor = .label
//        spinner.hidesWhenStopped = true
//        return spinner
//    }()
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
        print("A")
            tableType = "A"
            getTableAData()
        //present(TableAViewController(), animated: false)
        case 1:
            print("B")//present(TableAViewController(), animated: false)
            tableType = "B"
            getTableAData()
        case 2:
            print("C")//present(TableCViewController(), animated: false)
        default:
            print("A")//present(TableAViewController(), animated: false)
        }
    }
    
    public var tableType: String?
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .insetGrouped)
            
            tableView.backgroundColor = .systemBackground
            tableView.rowHeight = 100

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tableAVC = TableAViewController()
//        let tableBVC = TableBViewController()
//        let tableCVC = TableCViewController()
//
//        tableAVC.title = "Table A"
//        tableBVC.title = "Table B"
//        tableCVC.title = "Table C"
////
////        tableAVC.navigationItem.largeTitleDisplayMode = .always
////        tableBVC.navigationItem.largeTitleDisplayMode = .always
////        tableCVC.navigationItem.largeTitleDisplayMode = .always
////
//        let navTableAVC = UINavigationController(rootViewController: tableAVC)
//        let navTableBVC = UINavigationController(rootViewController: tableBVC)
//        let navTableCVC = UINavigationController(rootViewController: tableCVC)
////
////        navTableAVC.navigationBar.tintColor = .label
////        navTableBVC.navigationBar.tintColor = .label
////        navTableCVC.navigationBar.tintColor = .label
//
//        showDetailViewController(navTableAVC, sender: nil)
        view.addSubview(tableView)
        tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
        tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"), style: .done,
            target: self,
            action: #selector(didRefresh)
        )
        
        view.backgroundColor = .systemBackground
        //view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        scrollView.delegate = self
//        toggleView.delegate = self
//        view.addSubview(scrollView)
        //view.addSubview(toggleView)
        //view.addSubview(spinner)
        view.addSubview(segmentedControl)
//        scrollView.contentSize = CGSize(width: view.width*3, height: scrollView.height)
        
//        addChildren()
//        updateBarButtons()
        
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedControl.frame = CGRect(x: 0, y: view.safeAreaInsets.top+30, width: view.width, height: 40)
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height-100)
//        scrollView.frame = CGRect(
//            x: 0,
//            y: view.safeAreaInsets.top+55,
//            width: view.width,
//            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
 //       )
        
        //toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+50, width: view.width, height: 55)
    }
    private func getTableAData() {
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
    
    @objc func didRefresh() {
        //
    }

    private func updateBarButtons() {
        switch toggleView.state {
            case .tableA:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                // TO DO: add color when button is selected
            
        
            case .tableB:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                
                // TO DO: add color when button is selected
        
            case .tableC:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                
                // TO DO: add color when button is selected
        }
    }

    @objc private func didRefreshTable() {
        // Refresh table
    }
    
    private func addChildren() {
        
        addChild(tableAVC)
        scrollView.addSubview(tableAVC.view)
        tableAVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        tableAVC.didMove(toParent: self)
    
        addChild(tableBVC)
        scrollView.addSubview(tableBVC.view)
        tableBVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        tableBVC.didMove(toParent: self)
        
        addChild(tableCVC)
        scrollView.addSubview(tableCVC.view)
        tableCVC.view.frame = CGRect(x: view.width*2, y: 0, width: scrollView.width, height: scrollView.height)
        tableCVC.didMove(toParent: self)
    }
}
    
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateBarButtons()
    }
}

//extension ViewController: TablesToggleViewDelegate {
//    
//    func tablesToggleViewDidTapA(_ toggleView: TablesToggleView) {
//        let tableType = "A"
//        scrollView.setContentOffset(.zero, animated: false)
//        updateBarButtons()
//    }
//    
//    func tablesToggleViewDidTapB(_ toggleView: TablesToggleView) {
//        let tableType = "B"
//        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: false)
//        updateBarButtons()
//    }
//    
//    func tablesToggleViewDidTapC(_ toggleView: TablesToggleView) {
//        let tableType = "C"
//        scrollView.setContentOffset(CGPoint(x: view.width*2, y: 0), animated: false)
//        updateBarButtons()
//    }
//}

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
        
        let tableA = resultsA.first?.rates[indexPath.row]
        
        let rootVC = CurrencyAViewController(currency: tableA)
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.tintColor = .label
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
        
        present(navVC, animated: true)
        //navigationController?.pushViewController(vc, animated: true)
    
        print(tableA)
    }
    
}
