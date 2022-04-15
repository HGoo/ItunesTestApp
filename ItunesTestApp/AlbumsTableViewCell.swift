//
//  AlbumsTableViewCell.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Name album name"
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let artistNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Name artisi name"
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let trackCountNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "16 tracks"
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    var stackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumLogo.layer.cornerRadius = albumLogo.frame.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(albumLogo)
        self.addSubview(albumNameLabel)
        
        stackView = UIStackView(arrangedSubviews: [albumNameLabel, trackCountNameLable],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .equalSpacing)
        self.addSubview(stackView)
    }
    
    func configureAlbumCell(album: Album) {
        
        if let urlstring = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlstring) { [weak self] result in
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
            self.albumLogo.image = nil
        }
        
        albumNameLabel.text = album.collectionName
        artistNameLable.text = album.artistName
        trackCountNameLable.text = "\(album.trackCount) tracks"
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            albumLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            albumLogo.heightAnchor.constraint(equalToConstant: 60),
            albumLogo.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            albumNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: albumLogo.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])

      
    }
}

