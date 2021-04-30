//
//  AllCurrenciesViewController.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import UIKit

class AllCurrenciesViewController: BaseViewController<AllCurrenciesContentView, AllCurrenciesViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupTableView()
        getData()
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func getData() {
        viewModel.getCurrencies()
    }
}

extension AllCurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)
        let cell: AllCurrenciesCell = tableView.dequeueReusableCell(for: indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(model: item)
        return cell
    }
}

extension AllCurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension AllCurrenciesViewController: AllCurrenciesViewModelDelegate {
    func allCurrenciesViewModelDidUpdateItems(_ viewModel: AllCurrenciesViewModel) {
        contentView.tableView.reloadData()
    }
    
    func allCurrenciesViewModel(_ viewModel: AllCurrenciesViewModel, didFailWithError error: NetworkError) {
        print(error.localizedDescription)
    }
}

extension AllCurrenciesViewController: AllCurrenciesCellDelegate {
    func allCurrenciesCellDidTapAddButton(_ cell: AllCurrenciesCell, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else { return }
        viewModel.addCurrency(at: row)
    }
    
    func allCurrenciesCellDidTapRemoveButton(_ cell: AllCurrenciesCell, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else { return }
        viewModel.removeCurrency(at: row)
    }
}
