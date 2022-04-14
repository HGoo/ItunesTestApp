//
//  SongsCollectionViewCell.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        self.addSubview(nameSongLable)
        NSLayoutConstraint.activate([
            nameSongLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameSongLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameSongLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            nameSongLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
    }
}
