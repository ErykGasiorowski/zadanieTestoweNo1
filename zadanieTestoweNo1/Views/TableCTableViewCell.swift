//
//  TableCTableViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import UIKit

class TableCTableViewCell: UITableViewCell {

    static let identifier = "TableCTableViewCell"

    private let tradingDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let askLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bidLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(tradingDateLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(askLabel)
        contentView.addSubview(bidLabel)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(with viewModel: TableCTableViewCellViewModel) {
        tradingDateLabel.text = viewModel.tradingDate
        currencyLabel.text = viewModel.currency
        codeLabel.text = viewModel.code
        
        if let askValue = viewModel.ask {
            askLabel.text = String(askValue)
        }
        else {
            askLabel.text = "-"
        }
        
        if let bidValue = viewModel.bid {
            bidLabel.text = String(bidValue)
        }
        else {
            bidLabel.text = "-"
        }
    }
}
