//
//  HomeVC.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit

class HomeVC : UIViewController  {
    
    let viewModel = HomeViewModel()
    
    let scrollView = UIScrollView()
    var customerListView : CustomerListView?
    var customerList2View : CustomerListView?
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchJSONData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: view.frame.height * 1.1)
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
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalTo(view.snp.bottom)
        }

        
        let generalInfoView = GeneralInfoView(price: viewModel.object!.totalPrice!, Xadet: "\(viewModel.object!.totalPriceCount!)")
        scrollView.addSubview(generalInfoView)
        generalInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-60)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        customerListView = CustomerListView(
            company : (viewModel.object?.list![0].company)!,
            address: (viewModel.object?.list![0].address)!,
            installationNumber: (viewModel.object?.list![0].installationNumber)!,
            contractAccountNumber: (viewModel.object?.list![0].contractAccountNumber)!,
            amaount: (viewModel.object?.list![0].amount)!)
        customerListView?.viewButton.addTarget(self, action: #selector(clickPresentforHome), for: .touchUpInside)
       
        scrollView.addSubview(customerListView!)
        customerListView!.snp.makeConstraints { make in
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
        customerList2View!.viewButton.addTarget(self, action: #selector(clickPresentforJob), for: .touchUpInside)
        
        scrollView.addSubview(customerList2View!)
        customerList2View!.snp.makeConstraints { make in
            make.top.equalTo(customerListView!.snp.bottom).offset(32)
            make.left.right.equalTo(generalInfoView)
            make.height.lessThanOrEqualTo(380)
        }
        
    
    }
    
    @objc func clickPresentforHome(){
        let vc = InvoiceDetailsVC(homeViewModel: self.viewModel)
        vc.isJobAdress = false
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func clickPresentforJob(){
        let vc = InvoiceDetailsVC(homeViewModel: self.viewModel)
        vc.isJobAdress = true
        //vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
   
}


extension HomeVC: HomeViewModelDelegate {
    func invoicefetchSucceed(incoice: [Invoice]) {
        
    }
    
    func listfetchSucceed(list: [List]) {
        
    }
    
    
    func fetchSucceed(responce: Response) {
        UISetup()
    }
    
    func fetchFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}
