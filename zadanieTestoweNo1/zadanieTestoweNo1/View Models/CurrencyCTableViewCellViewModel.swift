//
//  CurrencyCTableViewCellViewModel.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 08/07/2021.
//

import Foundation

struct CurrencyCTableViewCellViewModel: Codable {
    let effectiveDate: String
    let ask: Double?
    let bid: Double?
}
