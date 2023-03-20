//
//  ImageStruct.swift
//  FreeImages
//
//  Created by Biagio Ricci on 20/03/23.
//

import Foundation

struct Images: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let download_url: String
}
