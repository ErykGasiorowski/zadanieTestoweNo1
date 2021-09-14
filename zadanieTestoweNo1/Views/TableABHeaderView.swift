//
//  TableABHeaderView.swift
//  zadanieTestoweNo1
//
//  Created by Eryk Gasiorowski on 23/08/2021.
//

import UIKit

class TableABHeaderView: UIView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
//        label.layer.borderWidth = 0.5
//        label.layer.borderColor = UIColor.lightGray.cgColor
        
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
    
    private let midLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchange rate"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(midLabel)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsPosition()
//        dateLabel.frame = CGRect(x: 10, y: 5, width: 80, height: 50)
//        currencyLabel.frame = CGRect(x: 110, y: 5, width: 80, height: 50)
//        codeLabel.frame = CGRect(x: 245, y: 5, width: 80, height: 50)
//        midLabel.frame = CGRect(x: 310, y: 5, width: 80, height: 50)
    }
}

extension TableABHeaderView {
    func labelsPosition() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(dateLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            //make.height.equalTo(60)
            $0.leading.equalToSuperview().offset(10)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.width.equalTo(currencyLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.4)
            $0.leading.equalTo(dateLabel.snp.trailingMargin).offset(10)
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
