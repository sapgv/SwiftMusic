//
//  ViewController.swift
//  SwiftMusic
//
//  Created by Grigory Sapogov on 27.12.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var viewModel: ViewModel!
    
    private let tableView = UITableView()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        self.view.backgroundColor = .systemBackground
        self.setupViewModel()
        self.setupTableView()
        self.setupRefreshControl()
        self.layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.update()
    }
    
    private func setupViewModel() {
        
        self.viewModel.updateCompletion = { [weak self] in
            
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
            
        }
        
    }

    private func setupTableView() {
        
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    private func setupRefreshControl() {
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc
    private func refresh() {
        
        self.update()
        
    }
    
    private func update() {
        
        let albumIds: [Int] = [1, 2, 3]
        
        self.viewModel.update(albumIds: albumIds)
        
    }
    
    private func layout() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    //MARK: - UITable View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.albums[section].tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let track = self.viewModel.albums[indexPath.section].tracks[indexPath.row]
        
        cell.textLabel?.text = track.name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let album = self.viewModel.albums[section]
        
        return album.name
        
    }

}

