//
//  AlertCustomView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import UIKit
import SnapKit

final class AlertCustomView: UIView {
    // UI elements for the alert view
    let headerLabel = UILabel()
    let descLabel = UILabel()
    let infoImageView = UIImageView()
    
    // Properties to store the content of the alert
    let info: String
    let header: String
    let desc: String
    
    // Custom "Tamam" (OK) button
    let button = CustomGradientButton(title: "Tamam")
    
    // Custom initializer to set the header and info for the alert view
    init(frame: CGRect = .zero, header: String, info: String) {
        self.header = header
        self.info = info
        self.desc = "Bu fatura \(info) tarihine kadar \nödenmesi gerekmektedir."
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to configure the alert view's layout and appearance
    func configure() {
        // Set corner radius and shadow properties for the view
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
  
        // Configure the alert icon
        infoImageView.image = UIImage(named: "ep_warning-filled")
        infoImageView.contentMode = .scaleAspectFill
        addSubview(infoImageView)
        infoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(18)
            // You can set custom constraints for the icon's size if needed
        }
        
        // Configure the header label
        headerLabel.font = UIFont(name: "Hind-Medium", size: 22)
        headerLabel.textColor = .black
        headerLabel.text = header
        headerLabel.textAlignment = .center
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(infoImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // Configure the description label
        descLabel.text = desc
        descLabel.font = UIFont(name: "Hind-Medium", size: 17)
        descLabel.textColor = .mainColor
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
        }
        
        // Configure the "Tamam" button
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
