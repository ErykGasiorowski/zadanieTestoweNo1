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

//protocol CurrencyViewModelNewInput: AnyObject {
//    func didTapButton(_: FirstTableType)
//}

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
       if tableType == "A" {
        fetchInitialData()
           //headerType = .headerAB //header?.headerType = .headerAB // i tu też chyba nie zadziała
        }
        else if tableType == "B" {
            fetchABData()
            //headerType = .headerAB //header?.headerType = .headerAB
        }
        else if tableType == "C" {
            fetchCData()
            //headerType = .headerAB //header?.headerType = .headerC
        }
        else {
            return
        }
    }
    
//    func didTapButton(_ table: FirstTableType) {
//        switch table {
//        case .typeAB(let model):
//            let currencyType = model
////            let rootVC = SecondViewController(currency: model.currency)
////            let navVC = UINavigationController(rootViewController: rootVC)
////
////            navVC.modalPresentationStyle = .fullScreen
////            navVC.navigationBar.tintColor = .label
//            //present(navVC, animated: true)
//            
//        case .typeC(let model):
//            let currencyType = model
////            let rootVC = SecondViewController(currency: model.currency)
////            let navVC = UINavigationController(rootViewController: rootVC)
////
////            navVC.modalPresentationStyle = .fullScreen
////            navVC.navigationBar.tintColor = .label
//            //present(navVC, animated: true)
//        }
//    }
//    
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
    
    private func fetchCData() {
        APICaller.shared.getDataForTableC(for: tableType) { [weak self] result in
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
