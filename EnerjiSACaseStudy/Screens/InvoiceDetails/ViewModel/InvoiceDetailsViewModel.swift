//
//  InvoiceDetailsViewModel.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 3.08.2023.
//

import Foundation
import Alamofire


protocol InvoiceDetailsViewModelDelegate : AnyObject {

    
}

protocol InvoiceDetailsViewModelProtocol{
    
    var  delegate : InvoiceDetailsViewModelDelegate? {get set}
    
    func numberOfRows(isJob: Bool) -> Int
    func cellForRow(isJob: Bool) -> [Invoice]?
    func price(isJob : Bool) -> String?
    
}

class InvoiceDetailsViewModel : InvoiceDetailsViewModelProtocol {
    
    
    
    var delegate: InvoiceDetailsViewModelDelegate?
    let viewModel : HomeViewModel
    
    init( viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
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
    
    func numberOfRows(isJob: Bool) -> Int {
        if !isJob {
            let filtered = viewModel.invoiceObject?.filter({$0.installationNumber == "4012312871"})
            return filtered?.count ?? 0
        } else {
            let filtered = viewModel.invoiceObject?.filter({$0.installationNumber == "4012310284"})
            return filtered?.count ?? 0
        }
        
    }
    
    func cellForRow(isJob: Bool) -> [Invoice]? {
        if !isJob {
            let filtered =  viewModel.invoiceObject?.filter({$0.installationNumber == "4012312871"})
            
            return filtered
        } else {
            let filtered =  viewModel.invoiceObject?.filter({$0.installationNumber == "4012310284"})
            
            return filtered
        }
    }
    
    func price(isJob : Bool) -> String? {
        if isJob {
            guard let totalString = viewModel.object?.totalPrice! else {return "0"}
            let totalNS = NSString(string: totalString)
            let totalNumber = totalNS.doubleValue
            print(totalNumber , "totalNumber" )
            guard  let otherAmount = viewModel.object?.list![0].amount! else {return "0"}
            let otherNS = NSString(string: otherAmount)
            let otherNumber = otherNS.doubleValue
            print(otherNumber , "otherNumber" )
            let amount = totalNumber - otherNumber
            let stringPrice = String(format:"%.4f", amount)
            return stringPrice
        } else {
            guard let totalString = viewModel.object?.totalPrice! else {return "0"}
            let totalNS = NSString(string: totalString)
            let totalNumber = totalNS.doubleValue
            print(totalNumber , "totalNumber" )
            guard  let otherAmount = viewModel.object?.list![1].amount! else {return "0"}
            let otherNS = NSString(string: otherAmount)
            let otherNumber = otherNS.doubleValue
            print(otherNumber , "otherNumber" )
            let amount = totalNumber - otherNumber
            let stringPrice = String(format:"%.3f", amount)
            return stringPrice
        }
    }
}
