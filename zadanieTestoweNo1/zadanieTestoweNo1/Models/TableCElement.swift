//
//  TableCElement.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import Foundation

struct TableCElement: Codable {
    let table, no, tradingDate: String
    let rates: [RateC]
}

struct RateC: Codable {
    let currency, code: String
    let ask: Double
    let bid: Double
}
