//
//  SongsModel.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 15.04.2022.
//

import Foundation


struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?

}
