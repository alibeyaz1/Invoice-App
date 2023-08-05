//
//  InvoiceTableViewCell.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 4.08.2023.
//
import UIKit
import SnapKit

class InvoiceTableViewCell: UITableViewCell {
    // Custom cell için özel view içerisindeki elemanlar
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    let invoiceButton = UIButton()
    let payButton = UIButton(type: .system)
    let separatorLine = UIView()
    
    static let identifier = "InvoiceCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Özel view içerisindeki elemanları eklemek için SnapKit kullanarak konumlandırma yapabilirsiniz
        let customView = UIView()
        addSubview(customView)
        customView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
    
        }
        
        var config = UIButton.Configuration.plain()
        config.title = "Öde"
        config.image = UIImage(named: "top")
        config.imagePlacement = .trailing
        config.baseForegroundColor = .clrYellow
        
        let payButton = UIButton(configuration: config)
        payButton.titleLabel?.font = UIFont(name: "Hind-SemiBold", size: 17)
        
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .trailing
        horizontalStackView.spacing = 20
        horizontalStackView.distribution = .equalSpacing


        horizontalStackView.addArrangedSubview(dateLabel)
        horizontalStackView.addArrangedSubview(amountLabel)
        horizontalStackView.addArrangedSubview(invoiceButton)
        horizontalStackView.addArrangedSubview(payButton)


        // StackView'leri "customView" içine yerleştirin
        customView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        dateLabel.font = UIFont(name: "Hind-Medium", size: 17)
        dateLabel.textColor = .mainColor
//        customView.addSubview(dateLabel)
//        dateLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(16)
//            make.centerY.equalToSuperview()
//        }
        
        amountLabel.font = UIFont(name: "Hind-Medium", size: 17)
        amountLabel.textColor = .mainColor
//        customView.addSubview(amountLabel)
//        amountLabel.snp.makeConstraints { make in
//            make.left.equalTo(dateLabel.snp.right).offset(4)
//            make.centerY.equalToSuperview()
//
//        }
        
      
        
    
//        customView.addSubview(payButton)
//        payButton.snp.makeConstraints { make in
//            make.right.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.height.equalTo(40)
//        }
        
        invoiceButton.setImage(UIImage(named: "invoice"), for: .normal)
        invoiceButton.imageView?.contentMode = .scaleAspectFit
//        customView.addSubview(invoiceButton)
//        invoiceButton.snp.makeConstraints { make in
//            make.right.equalTo(payButton.snp.left)
//            make.centerY.equalToSuperview()
//        }
        
        //        customView.addSubview(separatorLine)
        //        separatorLine.backgroundColor = .gray // Çizgi rengi
        //        separatorLine.snp.makeConstraints { make in
        //            make.leading.equalToSuperview().offset(16)
        //            make.trailing.equalToSuperview().offset(-16)
        //            make.height.equalTo(1)
        //            make.centerY.equalTo(customView)
        //        }
    }
}
