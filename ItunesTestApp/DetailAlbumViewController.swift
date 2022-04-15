//
//  DetailViewController.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class DetailAlbumViewController: UIViewController {
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumNameLable: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.text = "Name album"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let artistNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Name artist"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let releaseDateLable: UILabel = {
        let lable = UILabel()
        lable.text = "Release date"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let trackCountLable: UILabel = {
        let lable = UILabel()
        lable.text = "Tracks"
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var stackView = UIStackView()
    
    var album: Album?
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        setModel()
        fetchSongs(album: album)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(albumLogo)
        
        stackView = UIStackView(arrangedSubviews: [albumNameLable,
                                                   artistNameLable,
                                                   releaseDateLable,
                                                   trackCountLable],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        view.addSubview(stackView)
        view.addSubview(collectionview)
    }
    
    private func setupDelegate() {
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    private func setModel() {
        
        guard let album = album else { return }
        
        albumNameLable.text = album.collectionName
        artistNameLable.text = album.artistName
        trackCountLable.text = "\(album.trackCount) tracks:"
        releaseDateLable.text = setDateFormate(date: album.releaseDate)
        
        guard let url = album.artworkUrl100 else { return }
        
        
        setImage(urlString: url)
        
    }
    
    private func setDateFormate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ'"
        
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formateDate = DateFormatter()
        formateDate.dateFormat = "dd-MM-yyyy"
        let data = formateDate.string(from: backendDate)
        
        return data
    }
    
    private func setImage(urlString: String?) {
        
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url ) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self.albumLogo.image = image
                case .failure(let error):
                    self.albumLogo.image = nil
                    print("No almbom logo", error.localizedDescription)
                }
            }
        } else {
            albumLogo.image = nil
        }
    }
    
    private func fetchSongs(album: Album?) {
        
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songsModel, error in
            guard let self = self else { return }
            
            if error == nil {
                guard let songsModel = songsModel else { return }
                self.songs = songsModel.results
                self.collectionview.reloadData()
            } else {
                print(error!.localizedDescription)
                self.alertOk(titel: "Error", message: error!.localizedDescription)
            }
        }
    }
    
}

//MARK: - UITableViewDelegate

extension DetailAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SongsCollectionViewCell
        
        let song = songs[indexPath.row]
        cell.nameSongLable.text = song.trackName
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize (width: collectionView.frame.width,
               height: 20)
    }
}

//MARK: - Set Constarins

extension DetailAlbumViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            albumLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            albumLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumLogo.heightAnchor.constraint(equalToConstant: 100),
            albumLogo.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            collectionview.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 17),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
