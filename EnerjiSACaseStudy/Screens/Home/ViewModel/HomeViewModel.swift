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
    func fetchFailed(error : Error)
    
}

protocol HomeViewModelProtocol{
    
    var  delegate : HomeViewModelDelegate? {get set}
    
    func fetchJSONData()
    
    
}


class HomeViewModel : HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate?
    var object : Response?
    func fetchJSONData() {
        let url = "https://raw.githubusercontent.com/bydevelopertr/enerjisa/main/userInvoices.json"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ [self] resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(Response.self, from: data!)
                        self.object = jsonData
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

