//
//  CustomerListView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit
import SnapKit

final class CustomerListView: UIView {
    
    let companyLabel = UILabel()
    let addressLabel = UILabel()
    let addressDetailsLabel = UILabel()
    let installationNumberLabel = UILabel()
    let installationNumberDetailsLabel = UILabel()
    let installationNumberCopyButton = UIButton()
    let contractAccountNumberLabel  = UILabel()
    let contractAccountNumberDetailsLabel = UILabel()
    let contractAccountNumberCopyButton = UIButton()
    let amaountLabel = UILabel()
    let amountDetailsLabel = UILabel()
    let viewButton = CustomGradientButton(title: "Görüntüle")
    
    
    init(frame: CGRect = .zero,company : String,  address : String, installationNumber : String, contractAccountNumber : String, amaount : String) {
        super.init(frame: frame)
        configure(company : company,  address : address, installationNumber : installationNumber, contractAccountNumber : contractAccountNumber, amaount : amaount )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(company : String, address : String, installationNumber : String, contractAccountNumber : String, amaount : String) {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        companyLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        companyLabel.textColor = .mainColor
        companyLabel.text = company
        addSubview(companyLabel)
        companyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        let seperator1 = UIView()
        seperator1.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator1)
        seperator1.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        addressLabel.text = "Adres:"
        addressLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        addressLabel.textColor = .mainColor
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator1.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        
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
        
        let seperator2 = UIView()
        seperator2.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator2)
        seperator2.snp.makeConstraints { make in
            make.top.equalTo(addressDetailsLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        
    
        installationNumberLabel.text = "Tesisat Numarası:"
        installationNumberLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        installationNumberLabel.textColor = .mainColor
        addSubview(installationNumberLabel)
        installationNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator2.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        installationNumberCopyButton.setImage(UIImage(named: "copy"), for: .normal)
        addSubview(installationNumberCopyButton)
        installationNumberCopyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(installationNumberLabel.snp.top)
        }
        
        let formattedInstallationNumber = formatNumber(installationNumber, showFirstNCharacters: 3)
        
        installationNumberDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        installationNumberDetailsLabel.textColor = .mainColor
        installationNumberDetailsLabel.text = formattedInstallationNumber
        addSubview(installationNumberDetailsLabel)
        installationNumberDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(installationNumberLabel.snp.top)
            make.right.equalTo(installationNumberCopyButton.snp.left).offset(-10)
        }
        
        contractAccountNumberLabel.text = "Sözleşme \nHesap Numarası:"
        contractAccountNumberLabel.numberOfLines = 2
        contractAccountNumberLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        contractAccountNumberLabel.textColor = .mainColor
        addSubview(contractAccountNumberLabel)
        contractAccountNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(installationNumberLabel.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
            make.right.equalTo(center)
        }
        contractAccountNumberCopyButton.setImage(UIImage(named: "copy"), for: .normal)
        addSubview(contractAccountNumberCopyButton)
        contractAccountNumberCopyButton.snp.makeConstraints { make in
            make.centerY.equalTo(contractAccountNumberLabel.snp.centerY)
            make.right.equalToSuperview().offset(-12)
        }
        
        let formattedcontractAccountNumber = formatNumber(contractAccountNumber, showFirstNCharacters: 3)
        
        contractAccountNumberDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        contractAccountNumberDetailsLabel.textColor = .mainColor
        contractAccountNumberDetailsLabel.text = formattedcontractAccountNumber
        addSubview(contractAccountNumberDetailsLabel)
        contractAccountNumberDetailsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contractAccountNumberCopyButton.snp.centerY)
            make.right.equalTo(contractAccountNumberCopyButton.snp.left).offset(-10)
        }
        
        let seperator3 = UIView()
        seperator3.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        addSubview(seperator3)
        seperator3.snp.makeConstraints { make in
            make.top.equalTo(contractAccountNumberLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        
        amaountLabel.text = "Güncel Borç:"
        amaountLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        amaountLabel.textColor = .mainColor
        addSubview(amaountLabel)
        amaountLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator3.snp.bottom).offset(10)
            make.left.equalTo(companyLabel.snp.left)
        }
        
        amountDetailsLabel.font = UIFont(name: "Hind-Regular", size: 17)
        amountDetailsLabel.textColor = .mainColor
        amountDetailsLabel.text = "₺ \(amaount)"
        addSubview(amountDetailsLabel)
        amountDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator3.snp.bottom).offset(10)
            make.right.equalTo(companyLabel.snp.right)
        
        }
        addSubview(viewButton)
        viewButton.snp.makeConstraints { make in
            make.top.equalTo(amountDetailsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
    }
    
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
    
}










