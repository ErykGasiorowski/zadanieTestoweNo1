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
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        //sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
        //sv.distribution = .fill
        //sv.alignment = .center
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableCTableViewCell")
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(tradingDateLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(bidLabel)
        stackView.addArrangedSubview(askLabel)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsCPosition()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tradingDateLabel.text = nil
        currencyLabel.text = nil
        codeLabel.text = nil
        askLabel.text = nil
        bidLabel.text = nil
    }
    
    private var viewModels = [TableCTableViewCellViewModel]()
    
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

extension TableCTableViewCell {
    
    func labelsCPosition() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tradingDateLabel.snp.makeConstraints {
            //$0.width.equalTo(tradingDateLabel.frame.size.width + 10)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            //make.height.equalTo(60)
            $0.left.equalToSuperview().offset(10)
        }
        
        currencyLabel.snp.makeConstraints {
            //$0.width.equalTo(currencyLabel.frame.size.width + 10)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(tradingDateLabel.snp.right).offset(10)
            //            $0.bottom.equalTo(0)
        }
        
        codeLabel.snp.makeConstraints {
            //$0.width.equalTo(codeLabel.frame.size.width + 10)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.1)
            $0.left.equalTo(currencyLabel.snp.right)
        }
        
        bidLabel.snp.makeConstraints {
            //make.height.equalTo(60)
            //            $0.top.equalTo(-15)
            //$0.width.equalTo(bidLabel.frame.size.width)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(codeLabel.snp.right).inset(-5)
            //            $0.bottom.equalTo(0)
        }
        
        askLabel.snp.makeConstraints {
            //make.height.equalTo(60)
            //            $0.top.equalTo(-15)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(bidLabel.snp.right).offset(15)
            $0.right.equalToSuperview()
            //            $0.bottom.equalTo(0)
        }
    }
}
