//
//  SpecificCurrencyViewModel.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 21/11/2021.


//import Foundation
//import UIKit
//
//protocol SpecificCurrencyViewModelInput {
//    func viewDidLoad()
//    func refreshButtonTapped()
//    
//}
//
//protocol SpecificCurrencyViewModelOutput {
//    var resultAB: (([CurrencyABElement]) -> Void)? { get set }
//    //var resultC: (([CurrencyCElement]) -> Void)? { get set }
//    var onError: ((Error) -> Void)? { get set }
//    var reloadTableView: (() -> Void)? { get set }
//    var showLoading: ((Bool) -> Void)? { get set }
//    var tableType: String { get set }
//    var startDate: String { get set }
//    var endDate: String { get set }
//}
//
//protocol SpecificCurrencyViewModel: SpecificCurrencyViewModelInput, SpecificCurrencyViewModelOutput {}
//
//final class DefaultSpecCurrencyViewModel: SpecificCurrencyViewModel {
//    var resultAB: (([CurrencyABElement]) -> Void)?
//    //var resultC: (([CurrencyCElement]) -> Void)?
//    var onError: ((Error) -> Void)?
//    var reloadTableView: (() -> Void)?
//    var showLoading: ((Bool) -> Void)?
//    var tableType: String = ""
//    var startDate: String = ""
//    var endDate: String = ""
//    
//    
//    var header: TableABHeaderView? // to chyba nie zadziala
//    
//    func viewDidLoad() {
//        fetchData()
//        //header?.startingHeader()
//    }
//    
//    func refreshButtonTapped() {
//       if tableType == "A" {
//           fetchABData()
//           //headerType = .headerAB //header?.headerType = .headerAB // i tu też chyba nie zadziała
//        }
//        else if tableType == "B" {
//            fetchABData()
//            //headerType = .headerAB //header?.headerType = .headerAB
//        }
//        else if tableType == "C" {
//            fetchABData()
//            //headerType = .headerAB //header?.headerType = .headerC
//        }
//        else {
//            return
//        }
//    }
//    
//    private func fetchData() {
//        showLoading?(true)
//        if tableType == "A" {
//            APICaller.shared.getCurrencyABData(for: currency, with: startDate, with: endDate, with: table) { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let model):
//                        self.resultAB = model
//                        self.tableView.reloadData()
//                        //print(result)
//                        
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
////        else if tableType == "B" {
////            APICaller.shared.getCurrencyABData(for: currency, with: startDate, with: endDate, with: tableType) { result in
////                DispatchQueue.main.async {
////                    switch result {
////                    case .success(let model):
////                        self.resultAB = model
////                        self.tableView.reloadData()
////                        //print(result)
////                        
////                    case .failure(let error):
////                        print(error.localizedDescription)
////                    }
////                }
////            }
////        }
//        else if tableType == "C" {
//            APICaller.shared.getCurrencyCData(for: currency, with: startDate!, with: endDate!, with: table) { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let model):
//                        self.resultC = model
//                        self.tableView.reloadData()
//                        //print(result)
//                        
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
//}
//
//
