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
    var isJobAdress = false
    let personalInformationLabel = CustomLabel(text: "KİŞİSEL BİLGİLER")
    let nameTextField = CustomTextField(header: "Adınız ve Soyadınız", placeholder: "Adınız ve Soyadınız")
    let tcNumberTextField = CustomTextField(header: "T.C. Kimlik Numaranız", placeholder: "T.C. Kimlik Numaranız")
    let emailTextField = CustomTextField(header: "E-Posta Adresiniz", placeholder: "E-Posta Adresiniz")
    let phoneNumberTextField = CustomTextField(header: "Cep Telefonu Numaranız", placeholder: "Cep Telefonu Numaranız")
    let installationDetailsLabel = CustomLabel(text: "TESİSAT DETAYI")
    let warningLabel =  UILabel()
    
    var homeViewModel : HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewModel = InvoiceDetailsViewModel(viewModel: homeViewModel)
   
    let Xadet = String()
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let tableView = InvoiceTableView()

    var companyName: String = ""
     var address: String = ""
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        //        viewModel.fetchJSONData()
        tcNumberTextField.delegate = self
        UISetup()
        tableView.numberofRows = viewModel.numberOfRows(isJob: self.isJobAdress)
        tableView.invoiceObjects = viewModel.cellForRow(isJob: self.isJobAdress)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + (tableView.tableView.contentSize.height + 50) )
    }
    
    
    func UISetup(){
        
        lazy var headerView = HeaderView(title: "FATURA DETAYI", showBackButton: true )
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        headerView.backAction = {
            self.dismiss(animated: true)
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
            make.height.equalTo(2000)
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
            company : (isJobAdress ? homeViewModel.object?.list![1].company : homeViewModel.object?.list![0].company)! ,
            address:   (isJobAdress ? homeViewModel.object?.list![1].address : homeViewModel.object?.list![0].address)!,
            installationNumber:  (isJobAdress ? homeViewModel.object?.list![1].installationNumber : homeViewModel.object?.list![0].installationNumber)!,
            contractAccountNumber: (isJobAdress ? homeViewModel.object?.list![1].contractAccountNumber : homeViewModel.object?.list![0].contractAccountNumber)!,
            amaount:  (isJobAdress ? homeViewModel.object?.list![1].amount : homeViewModel.object?.list![0].amount)!)
       
        customerListView.viewButton.isHidden = true
        customerListView.amaountLabel.isHidden = true
        customerListView.amountDetailsLabel.isHidden = true
        contentView.addSubview(customerListView)
        customerListView.snp.makeConstraints { make in
            make.top.equalTo(installationDetailsLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(30)
            make.height.lessThanOrEqualTo(400)
        }
        guard let price = viewModel.price(isJob: self.isJobAdress) else {return}
        
        let unpaidInvoiceInfoView = UnpaidInvoiceInfoView(price: isJobAdress ? "\(homeViewModel.object!.list![1].amount!)" : "\(homeViewModel.object!.list![0].amount!)", Xadet : isJobAdress ? "\(homeViewModel.object!.list![1].amount?.count ?? 0)" : "\(homeViewModel.object!.list![0].amount!.count)")
        customerListView.addSubview(unpaidInvoiceInfoView)
        unpaidInvoiceInfoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(120)
        }
       
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
            tcNumberTextField.layer.borderColor = UIColor.clear.cgColor
        } else {
            // Geçerli değilse, kenar rengini kırmızı yap
            tcNumberTextField.layer.borderWidth = 1.0 // Kenarlık kalınlığı
            tcNumberTextField.layer.cornerRadius = 10.0
            tcNumberTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let ID = Int(text) {
            let isValidID = viewModel.validateCitizenshipID(ID: ID)
            updateTextFieldBorderColor(isValid: isValidID)
        } else {
            tcNumberTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Yeni metni hesaplayın
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            
            if newText.count <= 11 {
                if let ID = Int(newText) {
                    let isValidID = viewModel.validateCitizenshipID(ID: ID)
                    updateTextFieldBorderColor(isValid: isValidID)
                    updateWarningLabel(isValid: isValidID)
                } else {
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
            warningLabel.isHidden = true
            warningLabel.snp.removeConstraints()
        } else {
         
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





