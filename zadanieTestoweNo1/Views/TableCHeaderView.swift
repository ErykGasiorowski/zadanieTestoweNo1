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
    
    let horizontalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
//        sv.distribution = .fill
        sv.alignment = .center
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(dateLabel)
        horizontalStackView.addArrangedSubview(currencyLabel)
        horizontalStackView.addArrangedSubview(codeLabel)
        horizontalStackView.addArrangedSubview(rateLabel)
        horizontalStackView.addArrangedSubview(bidLabel)
        horizontalStackView.addArrangedSubview(askLabel)
        labelsCPosition()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsCPosition()
    }
}

extension TableCHeaderView {
    
    func labelsCPosition() {
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.2)
            $0.left.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
        }
        currencyLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(dateLabel.snp.right).offset(10)
            $0.top.bottom.equalToSuperview()
        }
        codeLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.1)
            $0.left.equalTo(currencyLabel.snp.right)
            $0.top.bottom.equalToSuperview()
        }
        rateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(codeLabel.snp.right).inset(-5)
        }
        bidLabel.snp.makeConstraints {
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(codeLabel.snp.right).inset(-5)
        }
        askLabel.snp.makeConstraints {
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(bidLabel.snp.right).offset(15)
            $0.right.equalToSuperview()
        }
    }
}
