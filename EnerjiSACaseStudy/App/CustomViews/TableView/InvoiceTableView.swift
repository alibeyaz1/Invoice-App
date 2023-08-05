//
//  InvoiceTableView.swift
//  EnerjiSACaseStudy
//
//  Created by Ali Beyaz on 4.08.2023.
//

import UIKit
import SnapKit

class InvoiceTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self

        // TableView için özel hücre sınıfını kaydet
        tableView.register(InvoiceTableViewCell.self, forCellReuseIdentifier: "InvoiceCell")
    }

    // MARK: - UITableViewDelegate & UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Tablonun satır sayısını döndürün (örneğin, veri kaynağınıza göre)
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         InvoiceHeader()
      }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceTableViewCell

        // Hücre içeriklerini burada güncelleyebilirsiniz (örneğin, veri kaynağınıza göre)
        cell.dateLabel.text = "29/08/2023"
        cell.amountLabel.text = "₺212"

        return cell
    }
}
