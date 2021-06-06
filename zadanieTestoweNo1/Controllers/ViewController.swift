//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableAButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let tableBButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let tableCButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Table C", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

//    private let spinner: UIActivityIndicatorView = {
//       let spinner = UIActivityIndicatorView()
//        spinner.tintColor = .label
//        spinner.hidesWhenStopped = true
//        return spinner
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //view.addSubview(spinner)
        view.addSubview(tableAButton)
        tableAButton.addTarget(self, action: #selector(didTapAButton), for: .touchUpInside)
        view.addSubview(tableBButton)
        tableBButton.addTarget(self, action: #selector(didTapBButton), for: .touchUpInside)
        view.addSubview(tableCButton)
        tableCButton.addTarget(self, action: #selector(didTapCButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableAButton.frame = CGRect(
            x: 25,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
        tableBButton.frame = CGRect(
            x: tableAButton.right+20,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
        tableCButton.frame = CGRect(
            x: tableBButton.right+20,
            y: view.safeAreaInsets.top+20,
            width: 100,
            height: 50
        )
    }
    
    @objc func didTapAButton() {

        
    }
    
    @objc func didTapBButton() {

        
    }
    
    @objc func didTapCButton() {

        
    }
    
}

