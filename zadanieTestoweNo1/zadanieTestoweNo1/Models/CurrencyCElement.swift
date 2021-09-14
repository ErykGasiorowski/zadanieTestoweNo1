//
//  CurrencyCElement.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 13/07/2021.
//

import Foundation


struct CurrencyCElement: Codable {
    let table, currency, code: String
    let rates: [CurrencyCRate]
}

struct CurrencyCRate: Codable {
    let no, effectiveDate: String
    let bid, ask: Double
}
