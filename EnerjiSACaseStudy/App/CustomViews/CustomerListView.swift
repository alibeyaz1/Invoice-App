//
//  CustomerListView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit
import SnapKit

// MARK: - CustomerListView
final class CustomerListView: UIView {
    // Labels and buttons for the view
    let companyLabel = CustomLabel()
    let addressLabel = CustomLabel()
    let addressDetailsLabel = UILabel()
    let installationNumberLabel = CustomLabel()
    let installationNumberDetailsLabel = UILabel()
    let installationNumberCopyButton = UIButton()
    let contractAccountNumberLabel  = CustomLabel()
    let contractAccountNumberDetailsLabel = UILabel()
    let contractAccountNumberCopyButton = UIButton()
    let amaountLabel = CustomLabel()
    let amountDetailsLabel = UILabel()
    var installationNumber = String()
    var contractAccountNumber = String()
    let viewButton = CustomGradientButton(title: "Görüntüle")
    
    // MARK: - Initializer
    init(frame: CGRect = .zero, company: String, address: String, installationNumber: String, contractAccountNumber: String, amaount: String) {
        super.init(frame: frame)
        configure(company: company, address: address, installationNumber: installationNumber, contractAccountNumber: contractAccountNumber, amaount: amaount)
        self.installationNumber = installationNumber
        self.contractAccountNumber = contractAccountNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    func configure(company: String, address: String, installationNumber: String, contractAccountNumber: String, amaount: String) {
        // Customize the appearance of the view
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
    
        companyLabel.text = company
        addSubview(companyLabel)
        companyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        // Add a separator view between the companyLabel and the addressLabel
        let seperator1 = UIView()
        seperator1.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator1)
        seperator1.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        // Configure the appearance of the addressLabel
        addressLabel.text = "Adres:"
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator1.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        
        // Configure the appearance of the addressDetailsLabel
        addressDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        addressDetailsLabel.textColor = .mainColor
        addressDetailsLabel.text = address
        addressDetailsLabel.numberOfLines = 2
        addSubview(addressDetailsLabel)
        addressDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom)
            make.left.equalTo(companyLabel.snp.left)
            make.right.equalTo(companyLabel.snp.right)
        }
        
        // Add a separator view between the addressDetailsLabel and the installationNumberLabel
        let seperator2 = UIView()
        seperator2.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator2)
        seperator2.snp.makeConstraints { make in
            make.top.equalTo(addressDetailsLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        // Configure the appearance of the installationNumberLabel
        installationNumberLabel.text = "Tesisat Numarası:"
        addSubview(installationNumberLabel)
        installationNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator2.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        
        // Configure the installationNumberCopyButton
        installationNumberCopyButton.addTarget(self, action: #selector(didTapCopyInstallationNumber), for: .touchUpInside)
        installationNumberCopyButton.setImage(UIImage(named: "copy"), for: .normal)
        addSubview(installationNumberCopyButton)
        installationNumberCopyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(installationNumberLabel.snp.top)
        }
        
        // Format the installationNumber to show only the first 3 characters and replace the rest with "X"
        let formattedInstallationNumber = formatNumber(installationNumber, showFirstNCharacters: 3)
        
        // Configure the appearance of the installationNumberDetailsLabel
        installationNumberDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        installationNumberDetailsLabel.textColor = .mainColor
        installationNumberDetailsLabel.text = formattedInstallationNumber
        addSubview(installationNumberDetailsLabel)
        installationNumberDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(installationNumberLabel.snp.top)
            make.right.equalTo(installationNumberCopyButton.snp.left).offset(-10)
        }
        
        // Configure the appearance of the contractAccountNumberLabel
        contractAccountNumberLabel.text = "Sözleşme \nHesap Numarası:"
        contractAccountNumberLabel.numberOfLines = 2
        addSubview(contractAccountNumberLabel)
        contractAccountNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(installationNumberLabel.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
            make.right.equalTo(center)
        }
        
        // Configure the contractAccountNumberCopyButton
        contractAccountNumberCopyButton.addTarget(self, action: #selector(didTapCopyContractAccountNumber), for: .touchUpInside)
        contractAccountNumberCopyButton.setImage(UIImage(named: "copy"), for: .normal)
        addSubview(contractAccountNumberCopyButton)
        contractAccountNumberCopyButton.snp.makeConstraints { make in
            make.centerY.equalTo(contractAccountNumberLabel.snp.centerY)
            make.right.equalToSuperview().offset(-12)
        }
        
        // Format the contractAccountNumber to show only the first 3 characters and replace the rest with "X"
        let formattedcontractAccountNumber = formatNumber(contractAccountNumber, showFirstNCharacters: 3)
        
        // Configure the appearance of the contractAccountNumberDetailsLabel
        contractAccountNumberDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        contractAccountNumberDetailsLabel.textColor = .mainColor
        contractAccountNumberDetailsLabel.text = formattedcontractAccountNumber
        addSubview(contractAccountNumberDetailsLabel)
        contractAccountNumberDetailsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contractAccountNumberCopyButton.snp.centerY)
            make.right.equalTo(contractAccountNumberCopyButton.snp.left).offset(-10)
        }
        
        // Add a separator view between the contractAccountNumberDetailsLabel and the amaountLabel
        let seperator3 = UIView()
        seperator3.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator3)
        seperator3.snp.makeConstraints { make in
            make.top.equalTo(contractAccountNumberLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        // Configure the appearance of the amaountLabel
        amaountLabel.text = "Güncel Borç:"
        addSubview(amaountLabel)
        amaountLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator3.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        
        // Configure the appearance of the amountDetailsLabel
        amountDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        amountDetailsLabel.textColor = .mainColor
        amountDetailsLabel.text = "₺ \(amaount)"
        addSubview(amountDetailsLabel)
        amountDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator3.snp.bottom).offset(10)
            make.right.equalTo(companyLabel.snp.right)
        }
        
        // Configure the appearance and constraints of the viewButton
        addSubview(viewButton)
        bringSubviewToFront(viewButton)
        viewButton.snp.makeConstraints { make in
            make.top.equalTo(amountDetailsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
    }
    
    // Helper method to format a number and show only the first N characters, replacing the rest with "X"
    func formatNumber(_ formatNumber: String, showFirstNCharacters: Int) -> String {
        var formatenedNumber = ""
        
        if formatNumber.count >= showFirstNCharacters {
            let startIndex = formatNumber.startIndex
            let endIndex = formatNumber.index(startIndex, offsetBy: showFirstNCharacters)
            formatenedNumber = String(formatNumber[startIndex..<endIndex]) + String(repeating: "X", count: formatNumber.count - showFirstNCharacters)
        } else {
            formatenedNumber = String(repeating: "X", count: formatNumber.count)
        }
        
        return formatenedNumber
    }
    
    // Helper method to copy the given number to the clipboard and show a feedback message to the user
    func copyNumberToClipboard(number: String) {
        // Copy the text to the clipboard
        UIPasteboard.general.string = number
        
        // Show a feedback message to the user after copying, for example:
        let alert = UIAlertController(title: "Kopyalandı", message: "\(number) panoya kopyalandı.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    // Action when the installationNumberCopyButton is tapped
    @objc func didTapCopyInstallationNumber() {
        copyNumberToClipboard(number: installationNumber)
    }

    // Action when the contractAccountNumberCopyButton is tapped
    @objc func didTapCopyContractAccountNumber() {
        copyNumberToClipboard(number: contractAccountNumber)
    }
}
