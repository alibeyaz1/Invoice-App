//
//  InvoiceDetailsViewModel.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import Foundation
import Alamofire


protocol InvoiceDetailsViewModelDelegate : AnyObject {
    
//    func fetchSucceed(responce: Response)
//    func fetchFailed(error : Error)
//
}

protocol InvoiceDetailsViewModelProtocol{
    
    var  delegate : InvoiceDetailsViewModelDelegate? {get set}
    
//    func fetchJSONData()

}

class InvoiceDetailsViewModel : InvoiceDetailsViewModelProtocol {
    
    var delegate: InvoiceDetailsViewModelDelegate?
    
    func validateCitizenshipID(ID: Int) -> Bool {
        let digits = ID.description.compactMap({ $0.wholeNumberValue })
        
        if digits.count == 11 && digits.first != 0 {
            let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
            let second  = (digits[1] + digits[3] + digits[5] + digits[7])
            
            let digit10 = (first - second) % 10
            let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
            
            if (digits[10] == digit11) && (digits[9] == digit10) {
                return true
            }
        }
        return false
    }
    
}
