//
//  CurrencyCTableViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyCTableViewCell: UITableViewCell {

    private let tradingDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let askLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bidLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "CurrencyCTableViewCell")
        
        addSubview(tradingDateLabel)
        addSubview(askLabel)
        addSubview(bidLabel)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tradingDateLabel.frame = CGRect(x: 10, y: 0, width: contentView.width, height: contentView.height)
        askLabel.frame = CGRect(x: 100, y: 0, width: contentView.width-10, height: contentView.height)
        bidLabel.frame = CGRect(x: 220, y: 0, width: contentView.width-10, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tradingDateLabel.text = nil
        askLabel.text = nil
        bidLabel.text = nil
    }
    
    private var viewModels = [TableCTableViewCellViewModel]()
    
    func configure(with viewModel: TableCTableViewCellViewModel) {
        tradingDateLabel.text = viewModel.tradingDate
        
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
