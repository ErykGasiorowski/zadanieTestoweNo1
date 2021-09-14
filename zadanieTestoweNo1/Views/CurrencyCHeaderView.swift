//
//  CurrencyCHeaderView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 25/08/2021.
//

import UIKit

class CurrencyCHeaderView: UIView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
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
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
        //sv.clipsToBounds = true
        //sv.spacing = 10
//        sv.distribution = .fill
        sv.alignment = .center
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(rateLabel)
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
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(stackView.snp.left).offset(10)
            $0.top.bottom.equalToSuperview()
        }
        rateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(stackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.6)
            $0.left.equalTo(dateLabel.snp.right).offset(10)
            $0.right.equalToSuperview().offset(10)
        }
        bidLabel.snp.makeConstraints {
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(dateLabel)
            $0.height.equalTo(stackView.snp.height).multipliedBy(0.4)
            $0.left.equalTo(dateLabel.snp.right).offset(10)
        }
        askLabel.snp.makeConstraints {
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(bidLabel)
            $0.height.equalTo(stackView.snp.height).multipliedBy(0.4)
            $0.left.equalTo(bidLabel.snp.right).offset(-10)
            $0.right.equalToSuperview().offset(10)
        }
    }
}
