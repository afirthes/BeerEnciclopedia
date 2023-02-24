//
//  ViewController.swift
//  BeerEnciclopedia
//
//  Created by Afir Thes on 24.02.2023.
//

import SnapKit
import UIKit

class BeerListViewController: UIViewController {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var beerList: [Beer] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }

    private func setupUI() {
        title = "Beer list"
        view.addSubview(tableView)
        view.backgroundColor = .systemYellow
        tableView.addSubview(refreshControl)

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(BeerListTableViewCell.self, forCellReuseIdentifier: BeerListTableViewCell.reusableId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemYellow

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupData() {
        NetworkService.shared.getBeerList { [weak self] beerList in
            guard let self else { return }
            self.beerList = beerList

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    @objc private func refreshData() {
        setupData()
    }
}

extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        beerList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.reusableId, for: indexPath) as? BeerListTableViewCell
        guard let cell else { return UITableViewCell() }
        let beer = beerList[indexPath.row]
        cell.configure(title: beer.name, image: beer.imageUrl, description: beer.description)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beerList[indexPath.row]
        navigationController?.pushViewController(BeerDetailsViewController(with: beer), animated: true)
    }
}
