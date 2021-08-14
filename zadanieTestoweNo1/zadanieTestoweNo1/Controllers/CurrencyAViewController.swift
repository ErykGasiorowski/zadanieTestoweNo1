//
//  CurrencyAViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyAViewController: UIViewController, DateInfoDelegate {
    
    let startDateTextField: UITextField = {
        let startDateTextField = UITextField()
        
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        startDateTextField.placeholder = "Enter Start Date here..."
        startDateTextField.font = UIFont.systemFont(ofSize: 12)
        startDateTextField.borderStyle = .bezel
        
        return startDateTextField
    }()
    
    let endDateTextField: UITextField = {
        let endDateTextField = UITextField()
        
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.placeholder = "Enter End Date here..."
        endDateTextField.font = UIFont.systemFont(ofSize: 12)
        endDateTextField.borderStyle = .bezel
        
        return endDateTextField
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Show rates", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    var resultAB: CurrencyABElement?
    
//    var startDate: String!
//    var endDate: String!
    
    private let currency: Rate?
    
    init(currency: Rate?) {
        self.currency = currency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var startDateText: String?
    var endDateText: String?
    
    // sprawdzić czy działa jak zacznie się wyświetlać ten widok po kliknięciu w tableview w home screenie
//    let date1: UITextField = {
//
//        let date1 = UITextField()
//
//        date1.translatesAutoresizingMaskIntoConstraints = false
//        date1.placeholder = "Enter Start Date here..."
//        date1.font = UIFont.systemFont(ofSize: 12)
//        date1.borderStyle = .bezel
//
//        return date1
//    }()
    // pole tekstowe do Start Date
    // end of comment
    
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .null, style: .insetGrouped)
            
            tableView.backgroundColor = .systemBackground
            tableView.register(CurrencyABTableViewCell.self, forCellReuseIdentifier: "CurrencyABTableViewCell")
            tableView.rowHeight = 50

        return tableView
    }()
    
    //var resultsA: [CurrencyABElement] = [CurrencyABElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(currency?.currency ?? "-")"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"), style: .done,
            target: self,
            action: #selector(didRefresh)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done,
            target: self,
            action: #selector(didClose)
        )
        
        view.addSubview(startDateTextField)
        view.addSubview(endDateTextField)

        view.addSubview(button2)
        
        self.startDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) // 1
        self.endDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDoneEnd)) // 1

        button2.addTarget(self, action: #selector(didTapbutton2), for: .touchUpInside)
        
        //getDateInfo()
//        getCurrencyAData()
    }
    
    func getStartDateText() -> String {
        return startDateTextField.text!
    }
    
    func getEndDateText() -> String {
        return endDateTextField.text!
    }
    
    @objc func didRefresh() {
        
        createSpinnerView()
        let startDate = startDateTextField.text!
        let endDate = endDateTextField.text!
        
        APICaller.shared.getCurrencyAData(for: currency, with: startDate, with: endDate) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.resultAB = model
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

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
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
        
        APICaller.shared.getCurrencyAData(for: currency, with: startDate, with: endDate) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.resultAB = model
                        self.tableView.reloadData()
                        print(result)

                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        
        button2.isHidden = true
        
//        print(startDateText!)
//        print(endDateText!)
    }
    
  
    
    // 2
    @objc func tapDone() {
        if let datePicker = self.startDateTextField.inputView as? UIDatePicker { // 2-1
            let dateFormatter = DateFormatter() // 2-2
            //dateFormatter.dateStyle = .medium // 2-3
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date) // 2-4
        }
        self.startDateTextField.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneEnd() {
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker { // 2-1
            let dateFormatter = DateFormatter() // 2-2
            //dateFormatter.dateStyle = .medium // 2-3
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date) // 2-4
        }
        self.endDateTextField.resignFirstResponder() // 2-5
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+220, width: view.width, height: view.height-300)
        startDateTextField.frame = CGRect(x: 0, y: view.safeAreaInsets.top+40, width: view.width/2, height: 50)
        endDateTextField.frame = CGRect(x: startDateTextField.right, y: view.safeAreaInsets.top+40, width: view.width/2, height: 50)
        
        button2.frame = CGRect(
            x: 80,
            y: startDateTextField.bottom+20,
            width: 100,
            height: 50
        )
    }
    
    func getStartDate() -> String {
        return startDateText!
    }
    
    func getEndDate() -> String {
        return endDateText!
    }
    
//    //func passDatesToAPI() {
//    let apiCaller = APICaller()
//    apiCaller.delegate = self
//    apiCaller.dateInfo()
//    //}
    
//    func getDateInfo() {
//        var startDateText: String = startDateTextField.text!
//        var endDateText: String = endDateTextField.text!
////
////        if startDateText != nil && endDateText != nil {
////            startDate = startDateText
////            endDate = endDateText
////        } else {
////            startDate = "2021-06-30"
////            endDate = "2021-07-20"
////        }
//        //print(startDateTextField.text)
//        //print(endDateTextField.text)
//
//
//        //let apiCaller = APICaller()
//        //apiCaller.startDateA = "\(startDateTextField.text!)"
//        //apiCaller.endDateA = "\(endDateTextField.text!)"
//
//   }
}


extension CurrencyAViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultAB?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = resultAB?.rates[indexPath.row]
        //let dateModel = resultAB
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyABTableViewCell", for: indexPath) as! CurrencyABTableViewCell

        cell.configure(with: CurrencyABTableViewCellViewModel(effectiveDate: model?.effectiveDate ?? "", mid: model?.mid))
        
        return cell
    }
    
    
}

extension UITextField {

    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: safeAreaInsets.top+40, width: screenWidth/3, height: 300))
        datePicker.datePickerMode = .date //2

        // iOS 14 and above
        if #available(iOS 14, *) {
            // Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker // 3

        // Create a toolbar and assign it to inputAccessoryView
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44)) // 4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // 5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let done = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: selector) // 7
        toolbar.setItems([cancel, flexible, done], animated: false) // 8
        self.inputAccessoryView = toolbar // 9
    }

    @objc func tapCancel() {
        self.resignFirstResponder()
    }

}
