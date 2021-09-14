//
//  CurrencyAViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyCViewController: UIViewController {
    
    private let cHeader = CurrencyCHeaderView()
    
    let startDateTextField: UITextField = {
        let startDateTextField = UITextField()
        
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        startDateTextField.placeholder = "Enter Start Date here..."
        startDateTextField.font = UIFont.systemFont(ofSize: 12)
        startDateTextField.layer.cornerRadius = 9
        startDateTextField.layer.borderWidth = 1
        startDateTextField.layer.masksToBounds = true
        startDateTextField.textColor = .label
        startDateTextField.layer.borderColor = UIColor.systemBlue.cgColor
        startDateTextField.tintColor = UIColor.label
        startDateTextField.borderStyle = .bezel
        
        return startDateTextField
    }()
    
    let endDateTextField: UITextField = {
        let endDateTextField = UITextField()
        
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.placeholder = "Enter End Date here..."
        endDateTextField.font = UIFont.systemFont(ofSize: 12)
        endDateTextField.layer.cornerRadius = 9
        endDateTextField.layer.borderWidth = 1
        endDateTextField.layer.masksToBounds = true
        endDateTextField.textColor = .label
        endDateTextField.layer.borderColor = UIColor.systemBlue.cgColor
        endDateTextField.tintColor = UIColor.label
        endDateTextField.borderStyle = .bezel
        
        return endDateTextField
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Show rates", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = UIColor.label
        return button
    }()
    
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
    
    var resultC: CurrencyCElement?
    
    private let currency: RateC?
    private let table: String
    
    init(currency: RateC?, table: String) {
        self.currency = currency
        self.table = table
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var startDateText: String?
    var endDateText: String?
    var tableType: String?
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .grouped)
        
        tableView.backgroundColor = .systemBackground
        tableView.register(CurrencyCTableViewCell.self, forCellReuseIdentifier: "CurrencyCTableViewCell")
        tableView.rowHeight = 50
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(currency?.currency ?? "-")"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        headerView.isHidden = true
        cHeader.isHidden = true
        view.addSubview(headerView)
        view.addSubview(cHeader)
        
        view.addSubview(startDateTextField)
        self.startDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        view.addSubview(endDateTextField)
        self.endDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDoneEnd))
        
        view.addSubview(button2)
        button2.addTarget(self, action: #selector(didTapbutton2), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"), style: .done,
                                                           target: self,
                                                           action: #selector(didRefresh)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done,
                                                            target: self,
                                                            action: #selector(didClose)
        )
    }
    
    @objc func didRefresh() {
        
        createSpinnerView()
        let startDate = startDateTextField.text!
        let endDate = endDateTextField.text!
        
        APICaller.shared.getCurrencyCData(for: currency, with: startDate, with: endDate, with: table) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultC = model
                    self.tableView.reloadData()
                    print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
    
    @objc func didClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapbutton2() {
        
        let startDate = startDateTextField.text!
        let endDate = endDateTextField.text!
        
        APICaller.shared.getCurrencyCData(for: currency, with: startDate, with: endDate, with: table) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultC = model
                    self.tableView.reloadData()
                    print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        button2.isHidden = true
        headerView.isHidden = false
        cHeader.isHidden = false
    }
    
    @objc func tapDone() {
        if let datePicker = self.startDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            //dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.startDateTextField.resignFirstResponder()
    }
    
    @objc func tapDoneEnd() {
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            //dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.endDateTextField.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tablePosition()
        dateTextFieldsPosition()
        buttonsPosition()
    }
}

extension CurrencyCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultC?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = resultC?.rates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCTableViewCell", for: indexPath) as! CurrencyCTableViewCell
        
        cell.configure(with: CurrencyCTableViewCellViewModel(effectiveDate: model?.effectiveDate ?? "", ask: model?.ask, bid: model?.bid))
        
        return cell
    }
}

extension UITextField {
    
    func setInputViewDatePickerC(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: safeAreaInsets.top+40, width: screenWidth/3, height: 300))
        datePicker.datePickerMode = .date
        
        // iOS 14 and above
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: selector)
        toolbar.setItems([cancel, flexible, done], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func tapCancelC() {
        self.resignFirstResponder()
    }
}

extension CurrencyCViewController {
    
    func dateTextFieldsPosition() {
        startDateTextField.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
        }
        endDateTextField.snp.makeConstraints {
            $0.left.equalTo(startDateTextField.snp.right)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
        }
    }
    
    func buttonsPosition() {
        button2.snp.makeConstraints {
            $0.top.equalTo(startDateTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
    }
    
    func tablePosition() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(startDateTextField.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
        }
        cHeader.snp.makeConstraints {
            $0.edges.equalTo(headerView)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
