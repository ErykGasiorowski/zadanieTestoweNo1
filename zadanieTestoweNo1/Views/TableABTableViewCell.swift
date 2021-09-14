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
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
        //sv.clipsToBounds = true
        //sv.spacing = 10
        sv.distribution = .fill
        sv.alignment = .center
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableABTableViewCell")
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(effectiveDateLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(midLabel)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModels = [TableABTableViewCellViewModel]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsPosition()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        effectiveDateLabel.text = nil
        currencyLabel.text = nil
        codeLabel.text = nil
        midLabel.text = nil
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

extension TableABTableViewCell {
    func labelsPosition() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        effectiveDateLabel.snp.makeConstraints {
            $0.width.equalTo(effectiveDateLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            //make.height.equalTo(60)
            $0.leading.equalToSuperview().offset(10)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.width.equalTo(currencyLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.4)
            $0.leading.equalTo(effectiveDateLabel.snp.trailingMargin).offset(10)
            //            $0.bottom.equalTo(0)
        }
        
        codeLabel.snp.makeConstraints {
            $0.width.equalTo(codeLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.1)
            $0.leading.equalTo(currencyLabel.snp.trailingMargin).offset(20)
        }
        
        midLabel.snp.makeConstraints {
            //make.height.equalTo(60)
            //            $0.top.equalTo(-15)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            $0.leading.equalTo(codeLabel.snp.trailingMargin).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            //            $0.bottom.equalTo(0)
        }
    }
}

        
