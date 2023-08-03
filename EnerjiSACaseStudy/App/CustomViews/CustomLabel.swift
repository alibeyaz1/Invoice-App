//
//  CustomLabel.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//


import UIKit
import SnapKit

class CustomLabel: UILabel {
    
    convenience init(text: String) {
           self.init()
           self.text = text
           setupUI()
       }
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Customizations for the label
        font = UIFont(name: "Hind-Semibold", size: 17)
        textColor = .mainColor
        textAlignment = .left
        numberOfLines = 1
        
        // SnapKit constraints
        snp.makeConstraints { make in
//            // Set your preferred constraints here.
//            // For example, let's set a fixed height and width for the label.
//            make.width.equalTo(200)
//            make.height.equalTo(40)
        }
    }
}
