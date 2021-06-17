//
//  TableABCollectionViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import Foundation
import UIKit

class TableABCollectionViewCell: UICollectionViewCell {
    static let identifier = "TableABCollectionViewCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(dateLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(rateLabel)
        contentView.clipsToBounds = true
        //self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: 15,
            height: 2
        )
        currencyLabel.frame = CGRect(
            x: 10,
            y: 2,
            width: 15,
            height: 2
        )
        codeLabel.frame = CGRect(
            x: 10,
            y: 2,
            width: 15,
            height: 2
        )
        rateLabel.frame = CGRect(
            x: 10,
            y: 2,
            width: 15,
            height: 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        currencyLabel.text = nil
        codeLabel.text = nil
        rateLabel.text = nil
    }
    
    func configure(with viewModel: TableABElement) {
                
        dateLabel.text = viewModel.effectiveDate
        currencyLabel.text = viewModel.rates.first?.currency
        codeLabel.text = viewModel.rates.first?.code
        
        if let value = viewModel.rates.first?.mid {
            rateLabel.text = String(value)
        }
        else {
            rateLabel.text = "-"
        }
    }
}
