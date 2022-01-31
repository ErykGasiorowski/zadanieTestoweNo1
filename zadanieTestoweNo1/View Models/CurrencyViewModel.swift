//
//  File.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 19/09/2021.
//

import Foundation
import UIKit

protocol CurrencyViewModelInput {
    func viewDidLoad()
    func refreshButtonTapped()
}

protocol CurrencyViewModelOutput {
    var successAB: (([TableABElement]) -> Void)? { get set }
    //var successC: (([TableCElement]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    var reloadTableView: (() -> Void)? { get set }
    var showLoading: ((Bool) -> Void)? { get set }
    var tableType: String { get set }
}

protocol CurrencyViewModel: CurrencyViewModelInput, CurrencyViewModelOutput {}

final class DefaultCurrencyViewModel: CurrencyViewModel {
      
    var successAB: (([TableABElement]) -> Void)?
    //var successC: (([TableCElement]) -> Void)?
    var onError: ((Error) -> Void)?
    var reloadTableView: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    var tableType: String = ""
    
    var header: TableABHeaderView? // to chyba nie zadziala
    
//    weak var delegate: CurrencyViewModelNewInput?
    
    func viewDidLoad() {
        fetchInitialData()
        //header?.startingHeader()
    }
    
    func refreshButtonTapped() {
            fetchABData()
    }
    
    private func fetchInitialData() {
        showLoading?(true)
        APICaller.shared.getDataForTableA(for: "A") { [weak self] result in
            executeOnMainThread {
                self?.showLoading?(false)
                switch result {
                case .success(let model):
                    self?.successAB?(model)
                    self?.reloadTableView?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
    
    private func fetchABData() {
        showLoading?(true)
        APICaller.shared.getDataForTableA(for: tableType) { [weak self] result in
            executeOnMainThread {
                self?.showLoading?(false)
                switch result {
                case .success(let model):
                    self?.successAB?(model)
                    self?.reloadTableView?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
