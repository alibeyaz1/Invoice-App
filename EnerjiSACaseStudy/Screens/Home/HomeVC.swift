//
//  HomeVC.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import UIKit

class HomeVC : UIViewController, HomeViewModelDelegate {
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchJSONData()
    }
    
    func UISetup(){
        
        
        let generalInfoView = GeneralInfoView(price: viewModel.object!.totalPrice!, Xadet: "\(viewModel.object!.totalPriceCount!)")
        view.addSubview(generalInfoView)
        generalInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        let customerListView = CustomerListView(
            company : (viewModel.object?.list![1].company)!,
            address: (viewModel.object?.list![1].address)!,
            installationNumber: (viewModel.object?.list![1].installationNumber)!,
            contractAccountNumber: (viewModel.object?.list![1].contractAccountNumber)!,
            amaount: (viewModel.object?.list![1].amount)!)
        
        view.addSubview(customerListView)
        customerListView.snp.makeConstraints { make in
            make.top.equalTo(generalInfoView.snp.bottom).offset(32)
            make.left.right.equalTo(generalInfoView)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        //        if let list = viewModel.object?.list {
        //            // Döngü ile tüm list elemanlarını dolaşın
        //            for (index, item) in list.enumerated() {
        //                // Her eleman için yeni bir CustomerListView oluşturun
        //                let customerListView = CustomerListView(address: item.address!, installationNumber: item.installationNumber!)
        //                view.addSubview(customerListView)
        //
        //                // Constraints ayarlamak için bir önceki customerListView referansını alın
        //                let previousCustomerListView = index == 0 ? generalInfoView : view.subviews[index - 1]
        //
        //                // Constraints ayarlamalarını yapın
        //                customerListView.snp.makeConstraints { make in
        //                    make.top.equalTo(previousCustomerListView.snp.bottom).offset(32)
        //                    make.left.right.equalTo(previousCustomerListView)
        //                    make.height.equalToSuperview().multipliedBy(0.4)
        //                }
        //            }
        //
        //            // Son customerListView referansını alın ve contentView'in alt kenarına sabitleyin
        //            if let lastCustomerListView = view.subviews.last {
        //                lastCustomerListView.snp.makeConstraints { make in
        //                    make.bottom.equalToSuperview().inset(16) // Örneğin alt kısımdan 16 birim içeride olsun
        //                }
        //            }
        //        }
        
    }
    
    
    
    func fetchSucceed(responce: Response) {
        UISetup()
    }
    
    func fetchFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}
