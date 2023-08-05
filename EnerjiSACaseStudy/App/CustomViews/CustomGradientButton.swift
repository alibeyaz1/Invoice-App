//
//  CustomGradientButton.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit

// MARK: - CustomGradientButton
class CustomGradientButton: UIButton {
    private let title: String?
    
    // MARK: - Initializer
    init(title: String?) {
        self.title = title
        super.init(frame: .zero)
        self.setupUI()
    }
    
    // This initializer is unavailable for use.
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the gradient layer's frame to match the button's bounds
        self.gradientLayer.frame = bounds
    }
    
    // MARK: - Gradient Layer
    lazy var gradientLayer: CAGradientLayer = {
        // Create a gradient layer with specific colors and set it as the button's background layer
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [UIColor(red: 0.988, green: 0.933, blue: 0.314, alpha: 1).cgColor,
                        UIColor(red: 0.933, green: 0.647, blue: 0.251, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    // MARK: - Setup UI
    func setupUI() {
        // Set the button's title and appearance
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Hind-SemiBold", size: 17)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.gradientLayer.cornerRadius = 10 // Apply corner radius to the gradient layer for rounded corners
    }
}
