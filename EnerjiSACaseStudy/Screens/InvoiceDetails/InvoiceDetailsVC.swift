//
//  InvoiceDetailsVC.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import Foundation

import UIKit
import Alamofire

class InvoiceDetailsVC : UIViewController, InvoiceDetailsViewModelDelegate, UITextFieldDelegate {
    
    let personalInformationLabel = CustomLabel(text: "KİŞİSEL BİLGİLER")
    let nameTextField = CustomTextField(header: "Adınız ve Soyadınız", placeholder: "Adınız ve Soyadınız")
    let tcNumberTextField = CustomTextField(header: "T.C. Kimlik Numaranız", placeholder: "T.C. Kimlik Numaranız")
    let emailTextField = CustomTextField(header: "E-Posta Adresiniz", placeholder: "E-Posta Adresiniz")
    let phoneNumberTextField = CustomTextField(header: "Cep Telefonu Numaranız", placeholder: "Cep Telefonu Numaranız")
    let installationDetailsLabel = CustomLabel(text: "TESİSAT DETAYI")
    let warningLabel =  UILabel()
    
    
    let viewModel = InvoiceDetailsViewModel()
    let homeViewModel = HomeViewModel()
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var companyName: String = ""
     var address: String = ""
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        //        viewModel.fetchJSONData()
        tcNumberTextField.delegate = self
        
        UISetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.4)
    }
    
    
    func UISetup(){
        
        lazy var headerView = HeaderView(title: "FATURA LİSTESİ", showBackButton: true )
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        view.addSubview(personalInformationLabel)
        personalInformationLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(personalInformationLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(32)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-28)
            make.height.equalTo(50)
        }
        
        tcNumberTextField.keyboardType = .numberPad
        contentView.addSubview(tcNumberTextField)
        tcNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(60)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(warningLabel)
        warningLabel.isHidden = true
        warningLabel.textColor = .red
        warningLabel.textAlignment = .left
        warningLabel.font =  UIFont(name: "Hind-Regular", size: 14)
        
        
        emailTextField.keyboardType = .emailAddress
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(tcNumberTextField.snp.bottom).offset(60)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(50)
        }
        phoneNumberTextField.keyboardType = .phonePad
        contentView.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(64)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(installationDetailsLabel)
        installationDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(23)
            make.left.right.equalTo(personalInformationLabel)
            
        }
        
        let customerListView = CustomerListView(
            company : "Evim",
            address:  "sadjşadsjşads",
            installationNumber:  "",
            contractAccountNumber: "",
            amaount:  "")
        /*
            company : (homeViewModel.object?.list![0].company)!,
            address: (homeViewModel.object?.list![0].address)!,
            installationNumber: (homeViewModel.object?.list![0].installationNumber)!,
            contractAccountNumber: (homeViewModel.object?.list![0].contractAccountNumber)!,
            amaount: (homeViewModel.object?.list![0].amount)!)
         */
//        customerListView.viewButton.addTarget(self, action: #selector(clickPresent), for: .touchUpInside)
        
        customerListView.viewButton.isHidden = true
        customerListView.amaountLabel.isHidden = true
        customerListView.amountDetailsLabel.isHidden = true
        contentView.addSubview(customerListView)
        customerListView.snp.makeConstraints { make in
            make.top.equalTo(installationDetailsLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(30)
            make.height.lessThanOrEqualTo(380)
        }
        
        var generalInfoView = GeneralInfoView(price: "", Xadet: "2")
        generalInfoView.textLabel.text = "Seçili sözleşme hesabınıza ait 2 adet ödenmemiş fatura bulunmaktadır."
        customerListView.addSubview(generalInfoView)
        generalInfoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(120)
        }
        
        let tableView = InvoiceTableView()

                  contentView.addSubview(tableView)
                  tableView.snp.makeConstraints { make in
                      make.top.equalTo(customerListView.snp.bottom).offset(20)
                      make.left.equalToSuperview().offset(20)
                      make.right.equalToSuperview().offset(-20)
                      make.height.equalTo(440)
                  }
        
        
        
    }
    
    func updateTextFieldBorderColor(isValid: Bool) {
        if isValid {
            // Eğer geçerli ise, kenar rengini sıfırla (varsayılan renk)
            tcNumberTextField.layer.borderColor = UIColor.clear.cgColor
        } else {
            // Geçerli değilse, kenar rengini kırmızı yap
            tcNumberTextField.layer.borderWidth = 1.0 // Kenarlık kalınlığı
            tcNumberTextField.layer.cornerRadius = 10.0
            tcNumberTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    // Bu fonksiyonu tcNumberTextField'ta her veri girişi yapıldığında çağırın
    func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let ID = Int(text) {
            let isValidID = viewModel.validateCitizenshipID(ID: ID)
            updateTextFieldBorderColor(isValid: isValidID)
        } else {
            // Geçersiz veri girildiyse kenar rengini sıfırla
            tcNumberTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // UITextFieldDelegate metodu, metin değişikliği sırasında çağrılır
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Yeni metni hesaplayın
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            
            // Metni 11 karakter ile sınırlayın
            if newText.count <= 11 {
                // Geçerli karakter sınırını aştığında, metin değişikliğine izin ver
                if let ID = Int(newText) {
                    let isValidID = viewModel.validateCitizenshipID(ID: ID)
                    updateTextFieldBorderColor(isValid: isValidID)
                    updateWarningLabel(isValid: isValidID)
                } else {
                    // Geçersiz veri girildiyse kenar rengini sıfırla
                    updateTextFieldBorderColor(isValid: false)
                }
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    func updateWarningLabel(isValid: Bool) {
        if isValid {
            // Geçerli kimlik numarası, uyarı label'ını gizle
            warningLabel.isHidden = true
            warningLabel.snp.removeConstraints() // Kullanılmayan kısıtlamaları kaldırın
        } else {
            // Geçersiz kimlik numarası, uyarı label'ını göster ve SnapKit ile konumlandırın
            warningLabel.isHidden = false
            warningLabel.text = "Geçersiz T.C. Kimlik Numarası"
            
            warningLabel.snp.makeConstraints { make in
                make.top.equalTo(tcNumberTextField.snp.bottom).offset(8)
                make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
                make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
                make.height.equalTo(20)
            }
        }
    }
}





