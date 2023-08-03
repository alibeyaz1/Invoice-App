//
//  AlertCustomView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import UIKit
import SnapKit

final class AlertCustomView: UIView {
    
    let headerLabel = UILabel()
    let descLabel = UILabel()
    let infoImageView = UIImageView()
    let info = String()
    let header = String()
    let button = CustomGradientButton(title: "Tamam")
    
    init(frame: CGRect = .zero, header: String, info: String) {
        super.init(frame: frame)
        configure(header: header, info: info)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(header: String, info: String) {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
  
        
        infoImageView.image = UIImage(named: "ep_warning-filled")
        infoImageView.contentMode = .scaleAspectFill
        addSubview(infoImageView)
        infoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(18)
//            make.height.width.equalToSuperview().multipliedBy(0.08)
        }
        
        headerLabel.font = UIFont(name: "Hind-Medium", size: 22)
        headerLabel.textColor = .black
        headerLabel.text = "Son Ödeme Tarihi"
        headerLabel.textAlignment = .center
        
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(infoImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        descLabel.text = "Bu fatura \(info) tarihine kadar \nödenmesi gerekmektedir."
        descLabel.font = UIFont(name: "Hind-Medium", size: 17)
        descLabel.textColor = .mainColor
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
        
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
        }
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)        }
        
        
        
    }
    
    
}
