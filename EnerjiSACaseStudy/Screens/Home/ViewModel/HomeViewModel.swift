//
//  HomeViewModel.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 2.08.2023.
//

import Foundation
import Alamofire


protocol HomeViewModelDelegate : AnyObject {
    
    func fetchSucceed(responce: Response)
    func invoicefetchSucceed(incoice: [Invoice])
    func listfetchSucceed(list: [List])
    func fetchFailed(error : Error)
    
}

protocol HomeViewModelProtocol{
    
    var  delegate : HomeViewModelDelegate? {get set}
    
    func fetchJSONData()
    
    
}


class HomeViewModel : HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate?
    var object : Response?
    var listObject : [List]? {
        didSet {
            self.delegate?.listfetchSucceed(list: listObject!)
        }
    }
    var invoiceObject : [Invoice]? {
        didSet {
            self.delegate?.invoicefetchSucceed(incoice: invoiceObject!)
        }
    }
    
    func fetchJSONData() {
        let url = "https://raw.githubusercontent.com/bydevelopertr/enerjisa/main/userInvoices.json"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ [self] resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(Response.self, from: data!)
                        self.object = jsonData
                        if let list = jsonData.list  {
                            self.listObject = list
                            delegate?.listfetchSucceed(list: list)
                        }
                        if let invoice = jsonData.invoices {
                            self.invoiceObject = invoice
                            delegate?.invoicefetchSucceed(incoice: invoice)
                        }
                        delegate?.fetchSucceed(responce: jsonData)
                        print(jsonData)
                    } catch {
                        delegate?.fetchFailed(error: error)
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}

