//
//  HomeVC.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit

class HomeVC : UIViewController, HomeViewModelDelegate {
    
    let viewModel = HomeViewModel()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var customerListView = CustomerListView(company: "", address: "", installationNumber: "", contractAccountNumber: "", amaount: "")
    var customerList2View = CustomerListView(company: "", address: "", installationNumber: "", contractAccountNumber: "", amaount: "")
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchJSONData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: customerList2View.frame.maxY + 32)
    }
    
    func UISetup(){
        
        
        lazy var headerView = HeaderView(title: "FATURA LİSTESİ")
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        let generalInfoView = GeneralInfoView(price: viewModel.object!.totalPrice!, Xadet: "\(viewModel.object!.totalPriceCount!)")
        contentView.addSubview(generalInfoView)
        generalInfoView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        customerListView = CustomerListView(
            company : (viewModel.object?.list![0].company)!,
            address: (viewModel.object?.list![0].address)!,
            installationNumber: (viewModel.object?.list![0].installationNumber)!,
            contractAccountNumber: (viewModel.object?.list![0].contractAccountNumber)!,
            amaount: (viewModel.object?.list![0].amount)!)
        customerListView.viewButton.addTarget(self, action: #selector(clickPresent), for: .touchUpInside)
        contentView.addSubview(customerListView)
        customerListView.snp.makeConstraints { make in
            make.top.equalTo(generalInfoView.snp.bottom).offset(32)
            make.left.right.equalTo(generalInfoView)
            make.height.lessThanOrEqualTo(380)
        }
        customerList2View = CustomerListView(
            company : (viewModel.object?.list![1].company)!,
            address: (viewModel.object?.list![1].address)!,
            installationNumber: (viewModel.object?.list![1].installationNumber)!,
            contractAccountNumber: (viewModel.object?.list![1].contractAccountNumber)!,
            amaount: (viewModel.object?.list![1].amount)!)
        
        
        contentView.addSubview(customerList2View)
        customerList2View.snp.makeConstraints { make in
            make.top.equalTo(customerListView.snp.bottom).offset(32)
            make.left.right.equalTo(generalInfoView)
            make.height.lessThanOrEqualTo(380)
        }
        
    }
    
    @objc func clickPresent(){
        
        let vc = InvoiceDetailsVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func fetchSucceed(responce: Response) {
        UISetup()
    }
    
    func fetchFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}
