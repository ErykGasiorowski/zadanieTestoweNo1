//
//  CurrencyAHeaderView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 25/08/2021.
//

import UIKit

class CurrencyAHeaderView: UIView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
//        label.layer.borderWidth = 0.5
//        label.layer.borderColor = UIColor.lightGray.cgColor
        
        return label
    }()
    
    private let midLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchange rate"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(dateLabel)
        self.addSubview(midLabel)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(x: 10, y: 5, width: 80, height: 50)
        midLabel.frame = CGRect(x: 150, y: 5, width: 80, height: 50)
    }
}
