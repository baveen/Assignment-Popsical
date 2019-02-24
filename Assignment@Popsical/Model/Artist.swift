//
//  Artist.swift
//  TestingAppPopsi
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

struct Artist: Codable {
    
    var id: Int
    var name: String?
    var altName: String?
    var gender: String?
    var langCodes: [String]?
    var images: [String: [String: String]]?
    var totalTracks: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case altName = "alt_name"
        case gender
        case langCodes = "lang_codes"
        case images
        case totalTracks = "total_tracks"
    }
    
}
