//
//  ViewController.swift
//  3.HW8
//
//  Created by Indira on 13/3/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
        private let searchBar = UISearchBar()
        private let tableView = UITableView()
        private let idCell = "cell"
        
        private var users = [String]()
        private var filtredUsers = [String]()
        private let images: [String] = ["28", "28", "28", "28", "28", "28", "28"]
        
        private var isFiltered: Bool = false
        
        let mainLabel: UILabel = {
           let label = UILabel()
            label.text = "Find New Friends"
            label.tintColor = .purple
            label.font = .boldSystemFont(ofSize: 18)
            label.textAlignment = .center
           return label
        }()
        
        private func setUpSubViews() {
            view.backgroundColor = .white
            navigationItem.title = "Profile"
            navigationItem.titleView = searchBar

            view.addSubview(mainLabel)
            mainLabel.snp.makeConstraints { make in
                make.trailing.leading.equalToSuperview().inset(114)
                make.height.equalTo(20)
                make.top.equalToSuperview().offset(120)
            }
            view.addSubview(searchBar)
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(mainLabel.snp.bottom).offset(20)
                make.trailing.leading.equalToSuperview()
            }
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.top.equalTo(searchBar.snp.bottom)
            }
        }
        private func initData() {
            users = ["Mia", "Isi", "Rasul", "Gulzat", "Diana", "Sascha", "Uluk"]
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpSubViews()
            initData()
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell )
            
            searchBar.delegate = self
            searchBar.placeholder = " Search..."
        }

    }

    extension ViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            isFiltered ? filtredUsers.count : users.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
            cell.imageView?.image = UIImage(named: images[indexPath.row])
            cell.detailTextLabel?.text = "Detail Label"
            cell.textLabel?.text = isFiltered ? filtredUsers[indexPath.row] : users[indexPath.row]
            return cell
        }
    }

    extension ViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                isFiltered = false
            } else {
                isFiltered = true
                filtredUsers = users.filter{ $0.lowercased().contains(searchText.lowercased()) }
            }
            
            tableView.reloadData()
        }

}
