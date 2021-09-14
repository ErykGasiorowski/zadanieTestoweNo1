//import UIKit
//
//class TableBViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var resultsA: [TableABElement] = [TableABElement]()
//    var currencyA: [Rate] = [Rate]()
//    
//    var resultsAB: CurrencyABElement?
//    
//    let tableView: UITableView = {
//        
//        let tableView = UITableView(frame: .null, style: .insetGrouped)
//            
//            tableView.backgroundColor = .systemBackground
//            tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
//            tableView.rowHeight = 100
//
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        //getTableAData()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: view.height-100)
//    }
//    
////    private func getTableAData() {
////        APICaller.shared.getDataForTableA { result in
////            DispatchQueue.main.async {
////                switch result {
////                case .success(let model):
////                    self.resultsA = model
////                    self.tableView.reloadData()
////                    //print(result)
////
////                case .failure(let error):
////                    print(error.localizedDescription)
////                }
////            }
////        }
////    }
//    
//    // MARK: - TableView funcs
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return resultsA.first?.rates.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let model = resultsA.first?.rates[indexPath.row]
//        let dateModel = resultsA
//        
//        let cell: TableABTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableABTableViewCell", for: indexPath) as! TableABTableViewCell
//
//        cell.configure(with: TableABTableViewCellViewModel(
//                        effectiveDate: dateModel.first?.effectiveDate ?? "",
//                        currency: model?.currency ?? "",
//                        code: model?.code ?? "",
//                        mid: model?.mid))
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let tableA = resultsA.first?.rates[indexPath.row]
//        
//        let rootVC = CurrencyAViewController(currency: tableA)
//        
//        let navVC = UINavigationController(rootViewController: rootVC)
//        navVC.modalPresentationStyle = .fullScreen
//        navVC.navigationBar.tintColor = .label
////        vc.navigationItem.largeTitleDisplayMode = .never
////        navigationController?.pushViewController(vc, animated: true)
//        
//        present(navVC, animated: true)
//        //navigationController?.pushViewController(vc, animated: true)
//    
//        print(tableA)
//    }
//    
//}
