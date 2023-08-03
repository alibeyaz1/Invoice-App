//
//  GeneralInfoView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit
import SnapKit

final class GeneralInfoView: UIView {
    
    let textLabel = UILabel()
    let priceLabel = UILabel()
    let subtitleLabel = UILabel()
    let infoIcon = UIImageView()
    
    init(frame: CGRect = .zero, price: String, Xadet: String) {
        super.init(frame: frame)
        configure(price: price, Xadet: Xadet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(price: String, Xadet: String) {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
  
        
        infoIcon.image = UIImage(named: "eva_info-fill")
        infoIcon.contentMode = .scaleAspectFill
        addSubview(infoIcon)
        infoIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(18)
            make.height.width.equalTo(24)
        }
        
        let stackView = UIStackView(arrangedSubviews: [subtitleLabel, priceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        
        subtitleLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        subtitleLabel.textColor = .mainColor
        subtitleLabel.text = "Toplam Borç:"
        priceLabel.text = "₺ \(price)"
        priceLabel.font = UIFont(name: "Hind-Regular", size: 17)
        priceLabel.textColor = .mainColor
        priceLabel.textAlignment = .right
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(infoIcon.snp.right).offset(12)
            make.right.equalToSuperview().offset(-22)
            make.height.equalTo(40)
        }
        
        
        
        textLabel.text = "Tüm sözleşme hesaplarınıza ait \(Xadet) adet ödenmemiş fatura bulunmaktadır."
        textLabel.numberOfLines = 0
        textLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        textLabel.textColor = .mainColor

        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(infoIcon.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-12)
        }
        
        
    }
    
    
}










