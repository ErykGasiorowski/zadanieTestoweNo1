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
    var resultsC: [TableABElement] = [TableABElement]()
    
    private let abHeader = TableABHeaderView()
    private let cHeader = TableCHeaderView()
    
//    let secondVC = SecondViewController(currency: String)
    
    private var viewModel: CurrencyViewModel
    //private var header: TableABHeaderView
    
    init(viewModel: CurrencyViewModel = DefaultCurrencyViewModel()) {
        self.viewModel = viewModel
        //self.header = header // , header: TableABHeaderView = TableABHeaderView()
        super.init(nibName: nil, bundle: nil)
    }
    // zrobić cellki do tabeli i headery w jednym pliku na switch
    
    
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
            viewModel.tableType = "A"
//            getTableABData()
            //header.headerType = .headerAB
            abHeader.isHidden = false
            cHeader.isHidden = true
            updateHeaderView()
            
        case 1:
            print("B")
            viewModel.tableType = "B"
//            getTableABData()
            //header.headerType = .headerAB
            abHeader.isHidden = false
            cHeader.isHidden = true
            updateHeaderView()
        case 2:
            viewModel.tableType = "C"
            //getTableCData()
            //header.headerType = .headerC
            abHeader.isHidden = true
            cHeader.isHidden = false
            updateHeaderView()
            print("C")
        default:
            viewModel.tableType = "A"
//            getTableABData()
            //header.headerType = .headerAB
            abHeader.isHidden = false
            cHeader.isHidden = true
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
        viewModel.successAB = { [weak self] in
            self?.resultsA = $0
        }
        
//        viewModel.successC = { [weak self] in
//            self?.resultsC = $0
//        }
        
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
        
        //tableType = "A"
        //header.headerType = .headerAB
        segmentedControlPosition()
        buttonPosition()
        headerPosition()
        tablePosition()
        //header.headerType = .headerAB
        //cHeader.isHidden = true
        updateHeaderView()
        
        
        setupBehavior()
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func didTapRefresh() {
        // dodać zmianę headerów w zależności od typu tabeli
        viewModel.refreshButtonTapped()
        //header.headerType = .headerC
        //header.headerC()
//        createSpinnerView()
//        tableView.reloadData()
    }
    
    
    // PRZERZUCIĆ DO ODDZIELNEGO PLIKU BO WYKORZYSTUJE TO SAMO W DRUGIM VC
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
        
        return resultsA.first?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = resultsA.first?.rates[indexPath.row]
        let dateModel = resultsA
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
//            let model = resultsA.first?.rates[indexPath.row]
//            let dateModel = resultsA
            
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
//            let model = resultsA.first?.rates[indexPath.row]
//            let dateModel = resultsA
            
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
//            let model = resultsC.first?.rates[indexPath.row]
//            let dateModel = resultsC
            
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
//            let model = resultsA.first?.rates[indexPath.row]
//            let dateModel = resultsA
            
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
        
        //        viewModel.didTapButton(result)
        //        viewModel.navVC.modalPresentationStyle = .fullScreen
        
        tableView.deselectRow(at: indexPath, animated: true)
        let result = resultsA.first?.rates[indexPath.row]
        let rootVC = SecondViewController(currency: result, table: resultsA.first?.table ?? "")
        let navVC = UINavigationController(rootViewController: rootVC)

        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.tintColor = .label
        present(navVC, animated: true)
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
