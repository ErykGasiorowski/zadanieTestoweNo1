//
//  GlobalScope.swift
//  zadanieTestoweNo1
//
//  Created by Damian Szejnoch on 19/09/2021.
//

import Foundation

func executeOnMainThread(_ code: @escaping (() -> Void)) {
    if Thread.isMainThread {
        code()
    } else {
        DispatchQueue.main.async(execute: code)
    }
}
