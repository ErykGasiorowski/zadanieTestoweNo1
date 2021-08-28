//
//  TableCHeaderView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 23/08/2021.
//

import UIKit

class TableCHeaderView: UIView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text = "Code"
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
        addSubview(currencyLabel)
        addSubview(codeLabel)
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
        currencyLabel.frame = CGRect(x: 90, y: 15, width: 80, height: 30)
        codeLabel.frame = CGRect(x: 195, y: 15, width: 80, height: 30)
        rateLabel.frame = CGRect(x: 240, y: 0, width: 160, height: 30)
        askLabel.frame = CGRect(x: 315, y: 25, width: 80, height: 30)
        bidLabel.frame = CGRect(x: 240, y: 25, width: 80, height: 30)
    }
}
