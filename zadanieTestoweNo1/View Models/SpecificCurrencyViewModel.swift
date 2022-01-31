//
//  SpecificCurrencyViewModel.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 21/11/2021.


import Foundation
import UIKit

protocol SpecificCurrencyViewModelInput {
    func viewDidLoad()
    func refreshButtonTapped()
    
    var table: Observable<String> { get }
    var currency: Observable<Rate?> { get }
}

protocol SpecificCurrencyViewModelOutput {
    var resultAB: (([CurrencyABElement]) -> Void)? { get set }
    //var resultC: (([CurrencyCElement]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    var reloadTableView: (() -> Void)? { get set }
    var showLoading: ((Bool) -> Void)? { get set }
    var tableType: String { get set }
    var startDate: String { get set }
    var endDate: String { get set }
}

protocol SpecificCurrencyViewModel: SpecificCurrencyViewModelInput, SpecificCurrencyViewModelOutput {}

final class DefaultSpecCurrencyViewModel: SpecificCurrencyViewModel {
    var resultAB: (([CurrencyABElement]) -> Void)?
    var table: Observable<String> = Observable("")
    var currency: Observable<Rate?> = Observable(nil)
    //var resultC: (([CurrencyCElement]) -> Void)?
    var onError: ((Error) -> Void)?
    var reloadTableView: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    var tableType: String = ""
    var startDate: String = ""
    var endDate: String = ""
    
    init(currency: Rate?, table: String) {
        self.currency.value = currency
        self.table.value = table
    }
    
    func viewDidLoad() {
        fetchData()
        //header?.startingHeader()
    }
    
    func refreshButtonTapped() {
        fetchData()
    }
    
    private func fetchData() {
        showLoading?(true)
        APICaller.shared.getCurrencyABData(for: currency, with: startDate, with: endDate, with: table) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.resultAB = model
                    self.tableView.reloadData()
                    //print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


