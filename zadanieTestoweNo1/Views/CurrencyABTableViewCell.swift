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
        super.init(style: .default, reuseIdentifier: "CurrencyABTableViewCell")
        
        addSubview(stackView)
        stackView.addArrangedSubview(effectiveDateLabel)
        stackView.addArrangedSubview(midLabel)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModels = [CurrencyABTableViewCellViewModel]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        effectiveDateLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.left.equalToSuperview().offset(10)
        }
        midLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.left.equalTo(effectiveDateLabel.snp.right)
            $0.right.equalToSuperview().offset(-10)
        }
//        effectiveDateLabel.frame = CGRect(x: 10, y: 0, width: contentView.width, height: contentView.height)
        //midLabel.frame = CGRect(x: 150, y: 0, width: contentView.width-10, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        effectiveDateLabel.text = nil
        midLabel.text = nil
    }
    
    func configure(with viewModel: CurrencyABTableViewCellViewModel) {
        effectiveDateLabel.text = viewModel.effectiveDate
        
        if let value = viewModel.mid {
            midLabel.text = String(value)
        }
        else {
            midLabel.text = "-"
        }
    }
}
