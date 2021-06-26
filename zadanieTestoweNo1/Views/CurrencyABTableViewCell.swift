//
//  CurrencyABTableViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyABTableViewCell: UITableViewCell {

    private let effectiveDateLabel: UILabel = {
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
        super.init(style: .default, reuseIdentifier: "CurrencyABTableViewCell")
        
        // contentview.addsubview(xxx)
        addSubview(effectiveDateLabel)
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
        midLabel.frame = CGRect(x: 150, y: 0, width: contentView.width-10, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        effectiveDateLabel.text = nil
        midLabel.text = nil
    }
    
    func configure(with viewModel: TableABTableViewCellViewModel) {
        effectiveDateLabel.text = viewModel.effectiveDate
        
        if let value = viewModel.mid {
            midLabel.text = String(value)
        }
        else {
            midLabel.text = "-"
        }
    }
}
