//
//  InvoiceTableHeaderViewCell.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 5.08.2023.
//

import UIKit
import SnapKit


final class InvoiceHeader: UIView {
    
    let dateHeaderLabel = UILabel()
    let amountHaderLabel = UILabel()
    

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI() {
        
        dateHeaderLabel.text = "Vade\nTarihi"
        dateHeaderLabel.font = UIFont(name: "Hind-Medium", size: 16)
        dateHeaderLabel.textColor = .mainColor
        dateHeaderLabel.textAlignment = .center
        dateHeaderLabel.numberOfLines = 2
        
        addSubview(dateHeaderLabel)
        dateHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.left.equalToSuperview().offset(30)
            
        }
        
        amountHaderLabel.text = "Ödenecek \nTutar"
        amountHaderLabel.font = UIFont(name: "Hind-Medium", size: 16)
        amountHaderLabel.textColor = .mainColor
        amountHaderLabel.textAlignment = .center
        amountHaderLabel.numberOfLines = 2
        
        addSubview(amountHaderLabel)
        amountHaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.left.equalTo(dateHeaderLabel.snp.right).offset(52)
            
        }
       
    }
}
