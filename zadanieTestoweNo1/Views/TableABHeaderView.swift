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
    
//    private let rateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Exchange rate:"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 12, weight: .bold)
//        label.numberOfLines = 1
//
//        return label
//    }()
//
//    private let askLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ask"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 12, weight: .bold)
//        label.numberOfLines = 1
//
//        return label
//    }()
//
//    private let bidLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Bid"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 12, weight: .bold)
//        label.numberOfLines = 1
//
//        return label
//    }()
    
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
    
//    let horizontalStackView: UIStackView = {
//        let sv = UIStackView()
//        sv.translatesAutoresizingMaskIntoConstraints = true
//        sv.axis = .horizontal
////        sv.distribution = .fill
//        sv.alignment = .center
//
//        return sv
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerAB()
        //startingLabelsPosition()
        //headerConfig()
//        if headerType == .headerAB {
//            headerAB()
//        }
//        else if headerType == .headerC {
//            headerC()
//        }
//        switch headerType {
//        case .headerAB:
//            headerAB()
//        case .headerC:
//            headerC()
//        default:
//            headerAB()
//            }
        //var headerType: HeaderType = .headerAB
//        switch headerType {
//        case .headerAB:
//            headerAB()
//        case .headerC:
//            headerC()
//        default:
//            headerAB()
//        }

            // MAM CHYYBA ROZWIĄZANIE W TUTORIALU ODNOSNIE ADVANCED ENUMS
        //headerC()
//        addSubview(stackView)
//        stackView.addArrangedSubview(dateLabel)
//        stackView.addArrangedSubview(currencyLabel)
//        stackView.addArrangedSubview(codeLabel)
//        stackView.addArrangedSubview(midLabel)
//
//        addSubview(horizontalStackView)
//        horizontalStackView.addArrangedSubview(dateLabel)
//        horizontalStackView.addArrangedSubview(currencyLabel)
//        horizontalStackView.addArrangedSubview(codeLabel)
//        horizontalStackView.addArrangedSubview(rateLabel)
//        horizontalStackView.addArrangedSubview(bidLabel)
//        horizontalStackView.addArrangedSubview(askLabel)
        
        clipsToBounds = true
    }
    
//    func headerConfig() {
//        if headerType == .headerAB {
////            horizontalStackView.removeFromSuperview()
////            askLabel.isHidden = true
////            bidLabel.isHidden = true
//            headerAB()
//        }
//
//    else if headerType == .headerC {
////        stackView.removeFromSuperview()
////        midLabel.isHidden = true
//        headerC()
//        }
//        else {
////            horizontalStackView.removeFromSuperview()
////            askLabel.isHidden = true
////            bidLabel.isHidden = true
//        headerAB()
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //headerConfig()
    }
    
//    func startingHeader() {
//        addSubview(stackView)
//        stackView.addArrangedSubview(dateLabel)
//        stackView.addArrangedSubview(currencyLabel)
//        stackView.addArrangedSubview(codeLabel)
//        stackView.addArrangedSubview(midLabel)
//        midLabel.isHidden = false
//        startingLabelsPosition()
//    }
    
    func headerAB() {
//        rateLabel.isHidden = true
//        bidLabel.isHidden = true
//        askLabel.isHidden = true
        addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(midLabel)
        //midLabel.isHidden = false
        labelsPosition()
    }
    
//    func headerC() {
//        midLabel.isHidden = true
//        addSubview(horizontalStackView)
//        horizontalStackView.addArrangedSubview(dateLabel)
//        horizontalStackView.addArrangedSubview(currencyLabel)
//        horizontalStackView.addArrangedSubview(codeLabel)
//        horizontalStackView.addArrangedSubview(rateLabel)
//        horizontalStackView.addArrangedSubview(bidLabel)
//        horizontalStackView.addArrangedSubview(askLabel)
//        rateLabel.isHidden = false
//        bidLabel.isHidden = false
//        askLabel.isHidden = false
//        labelsCPosition()
//    }
    
//    func headerTypeHandling(header: HeaderType) {
//        if header == HeaderType.headerAB {
//            stackView.isHidden = false
//            horizontalStackView.isHidden = true
//        } else if header == HeaderType.headerC {
//            stackView.isHidden = true
//            horizontalStackView.isHidden = false
//        }
//    }
}


extension TableABHeaderView {
//    func startingLabelsPosition() {
//
//        stackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        dateLabel.snp.makeConstraints {
//            $0.width.equalTo(dateLabel.frame.size.width + 10)
//            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
//            $0.leading.equalToSuperview().offset(10)
//        }
//        currencyLabel.snp.makeConstraints {
//            $0.width.equalTo(currencyLabel.frame.size.width + 10)
//            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.4)
//            $0.leading.equalTo(dateLabel.snp.trailingMargin).offset(10)
//        }
//        codeLabel.snp.makeConstraints {
//            $0.width.equalTo(codeLabel.frame.size.width + 10)
//            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.1)
//            $0.leading.equalTo(currencyLabel.snp.trailingMargin).offset(20)
//        }
//        midLabel.snp.makeConstraints {
//            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
//            $0.leading.equalTo(codeLabel.snp.trailingMargin).offset(10)
//            $0.trailing.equalToSuperview().offset(-10)
//        }
//    }
    
    func labelsPosition() {
        
        stackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        dateLabel.snp.remakeConstraints {
            $0.width.equalTo(dateLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            $0.leading.equalToSuperview().offset(10)
        }
        currencyLabel.snp.remakeConstraints {
            $0.width.equalTo(currencyLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.4)
            $0.leading.equalTo(dateLabel.snp.trailingMargin).offset(10)
        }
        codeLabel.snp.remakeConstraints {
            $0.width.equalTo(codeLabel.frame.size.width + 10)
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.1)
            $0.leading.equalTo(currencyLabel.snp.trailingMargin).offset(20)
        }
        midLabel.snp.remakeConstraints {
            $0.size.width.equalTo(stackView.snp.width).multipliedBy(0.2)
            $0.leading.equalTo(codeLabel.snp.trailingMargin).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
//    func labelsCPosition() {
//        horizontalStackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        dateLabel.snp.remakeConstraints {
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.2)
//            $0.left.equalToSuperview().offset(10)
//            $0.top.bottom.equalToSuperview()
//        }
//        currencyLabel.snp.remakeConstraints {
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
//            $0.left.equalTo(dateLabel.snp.right).offset(10)
//            $0.top.bottom.equalToSuperview()
//        }
//        codeLabel.snp.remakeConstraints {
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.1)
//            $0.left.equalTo(currencyLabel.snp.right)
//            $0.top.bottom.equalToSuperview()
//        }
//        rateLabel.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.3)
//            $0.left.equalTo(codeLabel.snp.right).inset(-5)
//        }
//        bidLabel.snp.makeConstraints {
//            $0.top.equalTo(rateLabel.snp.bottom)
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
//            $0.left.equalTo(codeLabel.snp.right).inset(-5)
//        }
//        askLabel.snp.makeConstraints {
//            $0.top.equalTo(rateLabel.snp.bottom)
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.4)
//            $0.width.equalTo(horizontalStackView.snp.width).multipliedBy(0.175)
//            $0.left.equalTo(bidLabel.snp.right).offset(15)
//            $0.right.equalToSuperview()
//        }
//    }
}
