//
//  UnpaidInvoiceInfoView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 5.08.2023.
//

import UIKit
import SnapKit

// MARK: - UnpaidInvoiceInfoView
final class UnpaidInvoiceInfoView: UIView {
    // Labels and image view for the view
    let textLabel = UILabel()
    let priceLabel = UILabel()
    let subtitleLabel = UILabel()
    let infoIcon = UIImageView()
    
    // MARK: - Initializer
    init(frame: CGRect = .zero, price: String, Xadet: String) {
        super.init(frame: frame)
        configure(price: price, Xadet: Xadet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    func configure(price: String, Xadet: String) {
        // Customize the appearance of the view
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
  
        // Configure the infoIcon UIImageView
        infoIcon.image = UIImage(named: "eva_info-fill")
        infoIcon.contentMode = .scaleAspectFill
        addSubview(infoIcon)
        infoIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(18)
            make.height.width.equalTo(24)
        }
        
        // Create a horizontal stack view to hold the subtitleLabel and priceLabel
        let stackView = UIStackView(arrangedSubviews: [subtitleLabel, priceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        // Configure the appearance of the subtitleLabel
        subtitleLabel.font = UIFont(name: "Hind-Semibold", size: 16)
        subtitleLabel.textColor = .mainColor
        subtitleLabel.text = "Toplam Borç:"
        
        // Configure the appearance of the priceLabel
        priceLabel.text = "₺ \(price)"
        priceLabel.font = UIFont(name: "Hind-Regular", size: 16)
        priceLabel.textColor = .mainColor
        priceLabel.textAlignment = .right
        
        // Add the stack view to the view and set its constraints
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(infoIcon.snp.right).offset(12)
            make.right.equalToSuperview().offset(-22)
            make.height.equalTo(40)
        }
        
        // Configure the textLabel
        textLabel.text = " Seçili sözleşme hesabınıza ait \(Xadet) \nadet ödenmemiş fatura bulunmaktadır."
        textLabel.numberOfLines = 2
        textLabel.font = UIFont(name: "Hind-Semibold", size: 14)
        textLabel.textColor = .mainColor
        textLabel.sizeToFit()
        
        // Add the textLabel to the view and set its constraints
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(infoIcon.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
    }
}
