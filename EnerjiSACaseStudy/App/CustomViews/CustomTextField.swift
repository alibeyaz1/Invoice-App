//
//  CustomTextField.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//


import SnapKit
import UIKit

/// Authentication TextField to respond all the necessities of the authenticator. Check "init" documentation for full detail
final class CustomTextField: UITextField {
    lazy var headerLabel = UILabel()

    
    /// Authentication TextField to respond all the necessities of the authenticator.
    /// - Parameters:
    ///   - frame: set to .zero by default
    ///   - header: give textfield an header text to represent it's functionality
    ///   - placeholder: set textfield placeholder text to indicate it's input type
    init(frame: CGRect = .zero, header: String, placeholder: String) {
        super.init(frame: frame)

        setAuthTextField(header: header, placeholder: placeholder)
    }
   
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func donePressed() {
        resignFirstResponder()
    }

    private func setAuthTextField(header: String, placeholder: String) {
        let doneButton = UITextField.ToolbarItem(title: "Done", target: self, selector: #selector(donePressed))

        self.addToolbar(leading: [], trailing: [doneButton])
        self.backgroundColor = .placeHolderBgColor
        self.layer.cornerRadius = 10
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.mainColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let myAttrString = NSAttributedString(string: placeholder, attributes: attribute)
        self.attributedPlaceholder = myAttrString
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        
        self.font = UIFont(name: "Hind-Regular", size: 17)
        self.textColor = .mainColor
        
  
        headerLabel.text = header
        headerLabel.font = UIFont(name: "Hind-Semibold", size: 17)
        headerLabel.textColor = .mainColor
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 1
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.top).offset(-10)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(24)
        }

    }
}


extension UITextField {
    typealias ToolbarItem = (title: String, target: Any, selector: Selector)

    func addToolbar(leading: [ToolbarItem] = [], trailing: [ToolbarItem] = []) {
        let toolbar = UIToolbar()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let leadingItems = leading.map { item in
            UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
        }

        let trailingItems = trailing.map { item in
            UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
        }

        var toolbarItems: [UIBarButtonItem] = leadingItems
        toolbarItems.append(flexibleSpace)
        toolbarItems.append(contentsOf: trailingItems)

        toolbar.setItems(toolbarItems, animated: false)
        toolbar.sizeToFit()

        inputAccessoryView = toolbar
    }
}
