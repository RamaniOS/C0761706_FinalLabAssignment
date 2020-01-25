//
//  ViewController.swift
//  C0761706_FinalLabAssignment
//
//  Created by Ramanpreet Singh on 2020-01-24.
//  Copyright © 2020 Ramanpreet Singh. All rights reserved.
//

import UIKit

class HomeViewController: AbstractViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // Variables
    private let persistenceManager = PersistenceManager.shared
    
    private var items: [Product]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        tableView.tableFooterView = UIView()
        fetchData()
        setupSearchBar()
        pushToDetail(with: (items?[0])!)
    }
    
    private func setupSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchData() {
        if !LocalData.isFirstLaunch {
            LocalData.isFirstLaunch = true
            LocalData.initItems()
        }
        persistenceManager.fetch(type: Product.self) { (products) in
            self.items = products
        }
    }
    
    @IBAction func addProductButtonClicked(_ sender: Any) {
        navigationController?.pushViewController(DetailViewController.control(With: .add), animated: true)
    }
    
    private var cellClass: ProductCell.Type {
        return ProductCell.self
    }
    
    internal func refresh() {
        fetchData()
    }
}

// MARK:- Manage Customer List
typealias CustomerListControl = HomeViewController
extension CustomerListControl: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellClass.reuseId, for: indexPath) as! ProductCell
        cell.product = items![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushToDetail(with: (items?[indexPath.row])!)
    }
    
    private func pushToDetail(with product: Product) {
        navigationController?.pushViewController(DetailViewController.control(With: .detail, and: product), animated: true)
    }
}

/*
 Manage search bar delegates
 */
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        persistenceManager.search(type: Product.self, keyword: search) { (products) in
            self.items = products
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh()
    }
    
}

