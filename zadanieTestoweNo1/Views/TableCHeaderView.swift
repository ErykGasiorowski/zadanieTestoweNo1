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
//        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(rateLabel)
//        verticalStackView.addArrangedSubview(horizontal2StackView)
        horizontalStackView.addArrangedSubview(bidLabel)
        horizontalStackView.addArrangedSubview(askLabel)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsCPosition()
//        dateLabel.frame = CGRect(x: 10, y: 15, width: 80, height: 30)
//        currencyLabel.frame = CGRect(x: 90, y: 15, width: 80, height: 30)
//        codeLabel.frame = CGRect(x: 195, y: 15, width: 80, height: 30)
//        rateLabel.frame = CGRect(x: 240, y: 0, width: 160, height: 30)
//        askLabel.frame = CGRect(x: 315, y: 25, width: 80, height: 30)
//        bidLabel.frame = CGRect(x: 240, y: 25, width: 80, height: 30)
    }
}

extension TableCHeaderView {
    
    func labelsCPosition() {
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.2)
            //make.height.equalTo(60)
            $0.left.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        currencyLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(dateLabel.snp.right).offset(10)
            $0.top.bottom.equalToSuperview()
            //            $0.bottom.equalTo(0)
        }
        
        codeLabel.snp.makeConstraints {
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.1)
            $0.left.equalTo(currencyLabel.snp.right)
            $0.top.bottom.equalToSuperview()
        }
        
//        verticalStackView.snp.makeConstraints {
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
//            $0.top.bottom.equalToSuperview()
//            $0.leading.equalTo(codeLabel.snp.trailingMargin)
//            $0.trailing.equalToSuperview().offset(-10)
//        }
        
        rateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
            $0.left.equalTo(codeLabel.snp.right).inset(-5)
        }
        
//        horizontal2StackView.snp.makeConstraints {
//            $0.top.equalTo(rateLabel.snp.bottom)
//            $0.height.equalTo(verticalStackView.snp.height).multipliedBy(0.7)
//            $0.bottom.equalToSuperview()
//        }
        
        bidLabel.snp.makeConstraints {
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(codeLabel.snp.right).inset(-5)
            //            $0.bottom.equalTo(0)
        }
        
        askLabel.snp.makeConstraints {
            //make.height.equalTo(60)
            $0.top.equalTo(rateLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
            $0.left.equalTo(bidLabel.snp.right).offset(15)
            $0.right.equalToSuperview()
        }
    }
}
