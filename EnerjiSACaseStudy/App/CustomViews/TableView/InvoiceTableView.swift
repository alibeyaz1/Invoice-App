//
//  InvoiceTableView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 4.08.2023.
//

import UIKit
import SnapKit

// MARK: - InvoiceTableViewDelegate
protocol InvoiceTableViewDelegate: AnyObject {
    // Delegate method to be called when a cell action is tapped
    func didTapCellAction()
}

// MARK: - InvoiceTableView
class InvoiceTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    // The main UITableView
    let tableView = UITableView()
    
    // The number of rows in the table view
    var numberofRows: Int? {
        didSet {
            // Reload the table view data on the main thread whenever the number of rows is updated
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // An array of Invoice objects to be displayed in the table view
    var invoiceObjects: [Invoice]? {
        didSet {
            // Reload the table view data on the main thread whenever the invoiceObjects are updated
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Setup Methods
    private func setupTableView() {
        // Add the tableView to the view hierarchy and set its constraints to match the superview
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Set the delegate and dataSource of the tableView to this class
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register the custom InvoiceTableViewCell for the tableView
        tableView.register(InvoiceTableViewCell.self, forCellReuseIdentifier: "InvoiceCell")
        tableView.isUserInteractionEnabled = true
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the tableView based on the numberofRows property
        return numberofRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the height for each row in the tableView
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Return the custom InvoiceHeader view to be used as the header view in the tableView
        return InvoiceHeader()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the custom InvoiceTableViewCell for each row in the tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceTableViewCell
        let item = self.invoiceObjects?[indexPath.row]
        
        // Set the cell's properties based on the corresponding Invoice object
        cell.selectionStyle = .none
        cell.dateLabel.text = item?.dueDate
        cell.amountLabel.text = "₺" + (item?.amount)!
        
        // Define the action closure for the cell
        cell.action = {
            // Create and display a custom AlertCustomView with a header and info
            let header = "Son Ödeme Tarihi"
            let info = "31.08.2023"
            let customView = AlertCustomView(header: header, info: info)
            
            self.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            // DispatchQueue is used to remove the customView after 3 seconds (delayed execution)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                customView.removeFromSuperview()
            }
        }
        
        return cell
    }
}
