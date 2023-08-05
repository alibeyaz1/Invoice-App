//
//  HeaderView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import SnapKit
import UIKit

final class HeaderView: UIImageView {
    var backAction : (() -> ())?
    let title: String?
    let titleLabel = UILabel()
    let backButton = UIButton()

    init(title: String?, showBackButton: Bool = false) {
        self.title = title
        super.init(frame: .zero)
        self.setupUI()
        self.setupBackButton(show: showBackButton)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonTapped() {
        backAction?()
    }

     override func layoutSubviews() {
         super.layoutSubviews()
     }

     func setupUI() {
         titleLabel.text = self.title
         titleLabel.font = UIFont(name: "Hind-SemiBold", size: 19)
         titleLabel.textColor = .white
         self.addSubview(titleLabel)
         titleLabel.snp.makeConstraints { make in
             make.centerY.equalToSuperview().offset(8)
             make.centerX.equalToSuperview()
         }

         self.image = UIImage(named: "headerBG")
         self.contentMode = .scaleToFill

         self.snp.makeConstraints { make in
             make.height.equalTo(5000)
         }
         
     }
    
   func setupBackButton(show: Bool) {
            backButton.setImage(UIImage(named: "back"), for: .normal) // Geri düğmesi için arka plan resmi
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            backButton.isHidden = !show // Gösterim durumunu belirle
            self.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16) // Sol tarafta 16 birim boşluk
                make.centerY.equalTo(titleLabel) // Başlık etiketi ile aynı dikey hizalama
                make.width.height.equalTo(24) // Düğme boyutları
            }
        }
 }

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
