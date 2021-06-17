//
//  TableABElement.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import Foundation

struct TableABElement: Codable {
    let table, no, effectiveDate: String
    let rates: [Rate]
}

struct Rate: Codable {
    let currency, code: String
    let mid: Double
}
