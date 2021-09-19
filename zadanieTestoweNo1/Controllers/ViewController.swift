//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var resultsA: [TableABElement] = [TableABElement]()
    var currencyA: [Rate] = [Rate]()
    var resultsC: [TableCElement] = [TableCElement]()
    
    private let abHeader = TableABHeaderView()
    private let cHeader = TableCHeaderView()
    
    private var viewModel: CurrencyViewModel
    
    init(viewModel: CurrencyViewModel = DefaultCurrencyViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//            getTableABData()
            updateHeaderView()
        case 1:
            print("B")
            tableType = "B"
//            getTableABData()
            updateHeaderView()
        case 2:
            tableType = "C"
            getTableCData()
            updateHeaderView()
            print("C")
        default:
            tableType = "A"
//            getTableABData()
            updateHeaderView()
            print("No table selected")
        }
    }
    
    public var tableType: String?
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .grouped)
        tableView.register(TableABTableViewCell.self, forCellReuseIdentifier: "TableABTableViewCell")
        tableView.register(TableCTableViewCell.self, forCellReuseIdentifier: "TableCTableViewCell")
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 50
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        
        return tableView
    }()
    
    func setupBehavior() {
        viewModel.success = { [weak self] in
            self?.resultsA = $0
        }
        
        viewModel.onError = { [weak self] in
            print($0.localizedDescription)
        }
        
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.showLoading = { [weak self] in
            self?.createSpinnerView()
            print("show loading or not \($0)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableType = "A"
        segmentedControlPosition()
        buttonPosition()
        headerPosition()
        tablePosition()
        updateHeaderView()
        
        
        setupBehavior()
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        viewModel.refreshButtonTapped()
//        createSpinnerView()
//        tableView.reloadData()
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
        //        view.addSubview(abHeader)
        //        view.addSubview(cHeader)
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

extension ViewController {
    
    func tablePosition() {
        // tableview
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headerView.snp_bottomMargin).offset(8)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func headerPosition() {
        // header
        view.addSubview(headerView)
        view.addSubview(abHeader)
        view.addSubview(cHeader)
        headerView.snp.makeConstraints {
            $0.width.equalTo(self.view.safeAreaInsets)
            $0.height.equalTo(60)
            $0.top.equalTo(button.snp_bottomMargin).offset(20)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
        abHeader.snp.makeConstraints {
            $0.width.equalTo(self.view.safeAreaInsets)
            $0.height.equalTo(60)
            $0.top.equalTo(button.snp_bottomMargin).offset(20)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
        cHeader.snp.makeConstraints { 
            $0.width.equalTo(self.view.safeAreaInsets)
            $0.height.equalTo(60)
            $0.top.equalTo(button.snp_bottomMargin).offset(20)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
    }
    
    func segmentedControlPosition() {
        // segmented control
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: view.width, height: 40))
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
    }
    
    
    func buttonPosition() {
        // button
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 80, height: 40))
            $0.top.equalTo(segmentedControl.snp_bottomMargin).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
