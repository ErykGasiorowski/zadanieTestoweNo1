//
//  CurrencyABElement.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 13/07/2021.
//

import Foundation

struct CurrencyABElement: Codable {
    let table, currency, code: String
    let rates: [CurrencyRate]
}

struct CurrencyRate: Codable {
    let no, effectiveDate: String
    let mid, ask, bid: Double?
}

    
