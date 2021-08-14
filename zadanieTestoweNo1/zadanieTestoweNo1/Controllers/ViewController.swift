//
//  ViewController.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableAVC = TableAViewController()
    private let tableBVC = TableBViewController()
    private let tableCVC = TableCViewController()
        
    private let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()

    private let toggleView = TablesToggleView()

//    private let spinner: UIActivityIndicatorView = {
//       let spinner = UIActivityIndicatorView()
//        spinner.tintColor = .label
//        spinner.hidesWhenStopped = true
//        return spinner
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tableAVC = TableAViewController()
//        let tableBVC = TableBViewController()
//        let tableCVC = TableCViewController()
//
//        tableAVC.navigationItem.largeTitleDisplayMode = .always
//        tableBVC.navigationItem.largeTitleDisplayMode = .always
//        tableCVC.navigationItem.largeTitleDisplayMode = .always
//
//        let navTableAVC = UINavigationController(rootViewController: tableAVC)
//        let navTableBVC = UINavigationController(rootViewController: tableBVC)
//        let navTableCVC = UINavigationController(rootViewController: tableCVC)
//
//        navTableAVC.navigationBar.tintColor = .label
//        navTableBVC.navigationBar.tintColor = .label
//        navTableCVC.navigationBar.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"), style: .done,
            target: self,
            action: #selector(didRefresh)
        )
        
        view.backgroundColor = .systemBackground
        
        scrollView.delegate = self
        toggleView.delegate = self
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        //view.addSubview(spinner)
        
        scrollView.contentSize = CGSize(width: view.width*3, height: scrollView.height)
        
        addChildren()
        updateBarButtons()
        
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        )
        
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+50, width: view.width, height: 55)
    }
    
    @objc func didRefresh() {
        //
    }

    private func updateBarButtons() {
        switch toggleView.state {
            case .tableA:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                // TO DO: add color when button is selected
            
        
            case .tableB:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                
                // TO DO: add color when button is selected
        
            case .tableC:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didRefreshTable))
                
                // TO DO: add color when button is selected
        }
    }

    @objc private func didRefreshTable() {
        // Refresh table
    }
    
    private func addChildren() {
        
        addChild(tableAVC)
        scrollView.addSubview(tableAVC.view)
        tableAVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        tableAVC.didMove(toParent: self)
    
        addChild(tableBVC)
        scrollView.addSubview(tableBVC.view)
        tableBVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        tableBVC.didMove(toParent: self)
        
        addChild(tableCVC)
        scrollView.addSubview(tableCVC.view)
        tableCVC.view.frame = CGRect(x: view.width*2, y: 0, width: scrollView.width, height: scrollView.height)
        tableCVC.didMove(toParent: self)
    }
}
    
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateBarButtons()
    }
}

extension ViewController: TablesToggleViewDelegate {
    
    func tablesToggleViewDidTapA(_ toggleView: TablesToggleView) {
        scrollView.setContentOffset(.zero, animated: false)
        updateBarButtons()
    }
    
    func tablesToggleViewDidTapB(_ toggleView: TablesToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: false)
        updateBarButtons()
    }
    
    func tablesToggleViewDidTapC(_ toggleView: TablesToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width*2, y: 0), animated: false)
        updateBarButtons()
    }
}
