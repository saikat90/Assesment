//
//  AboutCountryViewController.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class AboutCountryViewController: UIViewController {
    
    lazy var aboutCountryTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel: AboutCountryViewModel
    
    init(viewModel: AboutCountryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchCountryInformation()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.white
        aboutCountryTableView.tableFooterView = UIView(frame: CGRect.zero)
        aboutCountryTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutCountryTableView)
        NSLayoutConstraint.activate([
            aboutCountryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboutCountryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutCountryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutCountryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchCountryInformation() {
        viewModel.fetchCountryInformation()
    }
}

extension AboutCountryViewController: UITableViewDelegate {
    
}

extension AboutCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
