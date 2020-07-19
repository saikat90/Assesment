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
        tableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: CountryInfoTableViewCell.identifier)
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    private let viewModel: AboutCountryViewModel
    private lazy var downloadingOperation = InfoImageDownloadingOperation()
    
    init(viewModel: AboutCountryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.showActivityIndicator()
        configureView()
        fetchAboutTheCountryInformation()
        configurePullToRefresh()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.aboutCountryTableView.reloadData()
        }
        
        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.aboutCountryTableView.reloadData()
        }
        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.white
        aboutCountryTableView.tableFooterView = UIView(frame: CGRect.zero)
        aboutCountryTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutCountryTableView)
        NSLayoutConstraint.activate([
            aboutCountryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboutCountryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            aboutCountryTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            aboutCountryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configurePullToRefresh() {
        aboutCountryTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        fetchAboutTheCountryInformation()
    }
    
    private func fetchAboutTheCountryInformation() {
        viewModel.fetchCountryInformation { [weak self] in
            self?.reloadAboutCountryInformation()
        }
    }
    
    private func reloadAboutCountryInformation() {
        view.hideActivityIndicator()
        title = viewModel.navigationTitle ?? ""
        refreshControl.endRefreshing()
        aboutCountryTableView.reloadData()
    }
    
    fileprivate func startDownloadImageFor(model: CountryInfoCellViewModel,at indexPath: IndexPath) {
        guard downloadingOperation.downloadsInProgress[indexPath] == nil else {
            return
        }
        let downloader = InfoImageDownloader(model)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.downloadingOperation.downloadsInProgress.removeValue(forKey: indexPath)
                self.aboutCountryTableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        downloadingOperation.downloadsInProgress[indexPath] = downloader
        downloadingOperation.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func loadInfoImageOnVisibleCells() {
        if let paths = aboutCountryTableView.indexPathsForVisibleRows {
            let allDownloadingOperations = Set(downloadingOperation.downloadsInProgress.keys)
            let visiblePaths = Set(paths)
            let toCancelOperations = allDownloadingOperations.subtracting(visiblePaths)
            let toStartOperations = visiblePaths.subtracting(allDownloadingOperations)
            
            for indexPath in toCancelOperations {
                if let downloadOperation = downloadingOperation.downloadsInProgress[indexPath] {
                    downloadOperation.cancel()
                }
                downloadingOperation.downloadsInProgress.removeValue(forKey: indexPath)
            }
            for indexPath in toStartOperations {
                let model = viewModel.cellModelAt(index: indexPath.row)
                startDownloadImageFor(model: model, at: indexPath)
            }
        }
    }
    
    fileprivate func createErrorTableViewCellFor(_ model: CountryInfoCellViewModel) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = model.errorTitle
        tableViewCell.textLabel?.numberOfLines = 0
        return tableViewCell
    }
}

extension AboutCountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension AboutCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.cellModelAt(index: indexPath.row)
        guard let cellIdentifier = cellModel.cellIdentifier,
            let countryInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                                           for: indexPath) as? CountryInfoTableViewCell else {
                                                                            Logger.error(message: "Fail to create Cell")
                                                                            return createErrorTableViewCellFor(cellModel)
        }
        countryInfoTableViewCell.setUpWith(cellModel)
        switch cellModel.downloadingState {
        case .new:
            if !tableView.isDragging && !tableView.isDecelerating {
                startDownloadImageFor(model: cellModel, at: indexPath)
            }
        case .failed:
            Logger.error(message: "Image Downloading failed")
        default:
            Logger.info(message:"Image Downloading Success")
        }
        return countryInfoTableViewCell
    }
    
}


extension AboutCountryViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        downloadingOperation.downloadQueue.isSuspended = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadInfoImageOnVisibleCells()
            downloadingOperation.downloadQueue.isSuspended = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadInfoImageOnVisibleCells()
        downloadingOperation.downloadQueue.isSuspended = false
    }
}
