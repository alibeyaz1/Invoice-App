//
//  CustomLabel.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import UIKit
import SnapKit

// MARK: - CustomLabel
class CustomLabel: UILabel {
    
    // MARK: - Convenience Initializer
    convenience init(text: String) {
        self.init()
        self.text = text
        setupUI()
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Customizations for the label
        font = UIFont(name: "Hind-Semibold", size: 17)
        textColor = .mainColor
        textAlignment = .left
        numberOfLines = 1
        
    }
}
