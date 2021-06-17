//
//  TableABTableViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 06/06/2021.
//

import UIKit

class TableABTableViewCell: UITableViewCell {

        static let identifier = "TableABTableViewCell"

        private let effectiveDateLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = .systemFont(ofSize: 12, weight: .regular)
            label.numberOfLines = 1
            
            return label
        }()
        
        private let currencyLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = .systemFont(ofSize: 12, weight: .regular)
            label.numberOfLines = 0
            
            return label
        }()
        
        private let codeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = .systemFont(ofSize: 12, weight: .regular)
            label.numberOfLines = 1
            
            return label
        }()
        
        private let midLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = .systemFont(ofSize: 12, weight: .regular)
            label.numberOfLines = 1
            
            return label
        }()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: "TableABTableViewCell")
            
            // contentview.addsubview(xxx)
            addSubview(effectiveDateLabel)
            addSubview(currencyLabel)
            addSubview(codeLabel)
            addSubview(midLabel)
            clipsToBounds = true
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var viewModels = [TableABTableViewCellViewModel]()
    
        override func layoutSubviews() {
            super.layoutSubviews()
            effectiveDateLabel.frame = CGRect(x: 10, y: 0, width: contentView.width, height: contentView.height)
            currencyLabel.frame = CGRect(x: 90, y: 0, width: 120, height: contentView.height)
            codeLabel.frame = CGRect(x: 230, y: 0, width: contentView.width, height: contentView.height)
            midLabel.frame = CGRect(x: 270, y: 0, width: contentView.width-10, height: contentView.height)
            
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        effectiveDateLabel.text = nil
//        currencyLabel.text = nil
//        codeLabel.text = nil
//        midLabel.text = nil
    }
    
    func configure(with viewModel: TableABTableViewCellViewModel) {
        effectiveDateLabel.text = viewModel.effectiveDate
        currencyLabel.text = viewModel.currency
        codeLabel.text = viewModel.code
        
        
        if let value = viewModel.mid {
            midLabel.text = String(value)
        }
        else {
            midLabel.text = "-"
        }
    }
}
