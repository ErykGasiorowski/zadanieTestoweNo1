//
//  CurrencyCHeaderView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 25/08/2021.
//

import UIKit

class CurrencyCHeaderView: UIView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchange rate:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let askLabel: UILabel = {
        let label = UILabel()
        label.text = "Ask"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bidLabel: UILabel = {
        let label = UILabel()
        label.text = "Bid"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        addSubview(rateLabel)
        addSubview(askLabel)
        addSubview(bidLabel)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(x: 10, y: 15, width: 80, height: 30)
        rateLabel.frame = CGRect(x: 120, y: 0, width: 160, height: 30)
        askLabel.frame = CGRect(x: 190, y: 25, width: 80, height: 30)
        bidLabel.frame = CGRect(x: 120, y: 25, width: 80, height: 30)
    }
}
