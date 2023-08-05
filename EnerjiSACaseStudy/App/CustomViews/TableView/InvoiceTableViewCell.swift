//
//  InvoiceTableViewCell.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 4.08.2023.
//

import UIKit
import SnapKit

// MARK: - InvoiceTableViewCell
class InvoiceTableViewCell: UITableViewCell {
    // Labels and buttons for the cell
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    let invoiceButton = UIButton()
    let payButton = UIButton(type: .system)
    let separatorLine = UIView()
    
    // Identifier for cell reuse in the table view
    static let identifier = "InvoiceCell"
    
    // Action closure to be executed when the invoiceButton is tapped
    var action: (() -> ())?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Setup Method
    private func setupViews() {
        // Create a customView to hold the content with padding
        let customView = UIView()
        addSubview(customView)
        customView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // Configure the payButton with a custom style using UIButton.Configuration
        var config = UIButton.Configuration.plain()
        config.title = "Öde"
        config.image = UIImage(named: "top")
        config.imagePlacement = .trailing
        config.baseForegroundColor = .clrYellow
        
        let payButton = UIButton(configuration: config)
        payButton.titleLabel?.font = UIFont(name: "Hind-SemiBold", size: 17)
        
        // Create a horizontal stack view to arrange the labels and buttons side by side
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .trailing
        horizontalStackView.spacing = 20
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.isUserInteractionEnabled = false // Add this line to disable user interaction on the stack view
        
        // Add the labels and buttons to the horizontal stack view
        horizontalStackView.addArrangedSubview(dateLabel)
        horizontalStackView.addArrangedSubview(amountLabel)
        horizontalStackView.addArrangedSubview(invoiceButton)
        horizontalStackView.addArrangedSubview(payButton)
        
        // Add the horizontal stack view to the customView
        customView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        // Configure the appearance of dateLabel
        dateLabel.font = UIFont(name: "Hind-Medium", size: 17)
        dateLabel.textColor = .mainColor
        
        // Configure the appearance of amountLabel
        amountLabel.font = UIFont(name: "Hind-Medium", size: 17)
        amountLabel.textColor = .mainColor
        
        // Set the target and action for the invoiceButton
        invoiceButton.addTarget(self, action: #selector(didTapinvoiceButton), for: .touchUpInside)
        invoiceButton.setImage(UIImage(named: "invoice"), for: .normal)
        invoiceButton.imageView?.contentMode = .scaleAspectFit
    }
    
    // MARK: - Action Handler
    @objc func didTapinvoiceButton() {
        // Execute the action closure when the invoiceButton is tapped
        action?()
    }
}
