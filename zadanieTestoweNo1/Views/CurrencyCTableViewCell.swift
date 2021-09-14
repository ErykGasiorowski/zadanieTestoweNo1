//
//  CurrencyCTableViewCell.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 22/06/2021.
//

import UIKit

class CurrencyCTableViewCell: UITableViewCell {
    
    private let effectiveDateLabel: UILabel = {
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
        //sv.clipsToBounds = true
        //sv.spacing = 10
//        sv.distribution = .fill
//        sv.alignment = .center
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "CurrencyCTableViewCell")
        
        addSubview(stackView)
        stackView.addArrangedSubview(effectiveDateLabel)
        stackView.addArrangedSubview(bidLabel)
        stackView.addArrangedSubview(askLabel)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        effectiveDateLabel.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
            $0.left.equalToSuperview().offset(10)
        }
        bidLabel.snp.makeConstraints {
            $0.width.equalTo(effectiveDateLabel)
            $0.left.equalTo(effectiveDateLabel.snp.right).offset(10)
        }
        askLabel.snp.makeConstraints {
            $0.width.equalTo(bidLabel)
            $0.left.equalTo(bidLabel.snp.right).offset(-10)
            $0.right.equalToSuperview().offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        effectiveDateLabel.text = nil
        askLabel.text = nil
        bidLabel.text = nil
    }
    
    private var viewModels = [CurrencyCTableViewCellViewModel]()
    
    func configure(with viewModel: CurrencyCTableViewCellViewModel) {
        effectiveDateLabel.text = viewModel.effectiveDate
        
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
