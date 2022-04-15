//
//  AlbumsViewController.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier:  "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var timer: Timer?
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        setNnavigatinBar()
        setupSearchController()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNnavigatinBar() {
        navigationItem.title = "Albums"
        //navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func fetchAlbums(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&atribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albulModel, error in
            guard let self = self else { return }
            
            if error == nil {
                guard let albulModel = albulModel else { return }
                
                if albulModel.results != [] {
                    let sortedAlboms = albulModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self.albums = sortedAlboms
                    self.tableView.reloadData()
                } else {
                    self.alertOk(titel: "Error", message: "Albom not found. Change search")
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        
        let album = albums[indexPath.row]
        cell.configureAlbumCell(album: album)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailAlbumViewController()
        
        let album = albums[indexPath.row]
        detailViewController.album = album
        detailViewController.title = album.artistName
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension AlbumsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { [weak self] _ in
                guard let self = self else { return }
                self.fetchAlbums(albumName: text!)
            })
        }
    }
}

//MARK: - Set Constarins

extension AlbumsViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
