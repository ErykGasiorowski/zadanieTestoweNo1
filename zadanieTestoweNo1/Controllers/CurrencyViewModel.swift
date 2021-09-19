//
//  File.swift
//  zadanieTestoweNo1
//
//  Created by Damian Szejnoch on 19/09/2021.
//

import Foundation

protocol CurrencyViewModelInput {
    func viewDidLoad()
    func refreshButtonTapped()
}

protocol CurrencyViewModelOutput {
    var success: (([TableABElement]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    var reloadTableView: (() -> Void)? { get set }
    var showLoading: ((Bool) -> Void)? { get set }
}

protocol CurrencyViewModel: CurrencyViewModelInput, CurrencyViewModelOutput {}

final class DefaultCurrencyViewModel: CurrencyViewModel {
    
    var success: (([TableABElement]) -> Void)?
    var onError: ((Error) -> Void)?
    var reloadTableView: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    
    func viewDidLoad() {
        fetchInitialData()
    }
    
    func refreshButtonTapped() {
        fetchInitialData()
    }
    
    private func fetchInitialData() {
        showLoading?(true)
        APICaller.shared.getDataForTableA(for: "A") { [weak self] result in
            executeOnMainThread {
                self?.showLoading?(false)
                switch result {
                case .success(let model):
                    self?.success?(model)
                    self?.reloadTableView?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
