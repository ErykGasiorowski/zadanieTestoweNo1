//
//  TablesToggleView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 20/06/2021.
//

import UIKit

protocol TablesToggleViewDelegate: AnyObject {
    func tablesToggleViewDidTapA(_ toggleView: TablesToggleView)
    func tablesToggleViewDidTapB(_ toggleView: TablesToggleView)
    func tablesToggleViewDidTapC(_ toggleView: TablesToggleView)
}

class TablesToggleView: UIView {

    enum State {
        
        case tableA
        case tableB
        case tableC
    }
    
    var state: State = .tableA
    
    var tableType: String?

    weak var delegate: TablesToggleViewDelegate?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableAButton)
        tableAButton.addTarget(self, action: #selector(didTapAButton), for: .touchUpInside)
        
        addSubview(tableBButton)
        tableBButton.addTarget(self, action: #selector(didTapBButton), for: .touchUpInside)
        
        addSubview(tableCButton)
        tableCButton.addTarget(self, action: #selector(didTapCButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapAButton() {
        state = .tableA
        delegate?.tablesToggleViewDidTapA(self)
        
        }
    
        @objc func didTapBButton() {
            
            state = .tableB
            delegate?.tablesToggleViewDidTapB(self)
            let tableType = "B"
        }
    
        @objc func didTapCButton() {
            
            state = .tableC
            delegate?.tablesToggleViewDidTapC(self)  
            let tableType = "C"
        }
        
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableAButton.frame = CGRect(
            x: 25,
            y: 0,
            width: 100,
            height: 50
        )
        tableBButton.frame = CGRect(
            x: tableAButton.right+20,
            y: 0,
            width: 100,
            height: 50
        )
        tableCButton.frame = CGRect(
            x: tableBButton.right+20,
            y: 0,
            width: 100,
            height: 50
        )
    }
}
