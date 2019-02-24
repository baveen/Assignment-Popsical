//
//  Track.swift
//  TestingAppPopsi
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

struct BlockReason: Codable {
    var countryBlocked: Bool?
    var platformBlocked: Bool?
    var timeLapsedBlocked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case countryBlocked = "country_blocked"
        case platformBlocked = "platform_blocked"
        case timeLapsedBlocked = "time_lapsed_blocked"
    }
    
}

struct TrackArtists: Codable {
    var type: String?
    var artist: Artist?
}


struct Track: Codable {
    
    var id: Int
    var number: Int?
    var title: String?
    var altTitle: String?
    var langCode: String?
    var runTime: Int?
    var releaseDate: String?
    var hasVideo: Bool?
    var genres: [String?]
    var source: String?
    var images: [String: [String:String]]?
    var lyricsCount: Int?
    var block: Bool?
    var originalLyricUrl: String?
    var hasLrc: Bool?
    var musicFeatureKey: Int?
    var musicFeatureIsMajor: Int?
    var blockedReason: BlockReason?
    var trackArtists: [TrackArtists?]
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case number
        case title
        case genres
        case source
        case images
        case block
        case altTitle = "alt_title"
        case langCode = "lang_code"
        case runTime = "run_Time"
        case releaseDate = "release_date"
        case hasVideo = "has_video"
        case lyricsCount = "lyrics_count"
        case originalLyricUrl = "original_lyric_url"
        case hasLrc = "has_lrc"
        case musicFeatureKey = "music_feature_key"
        case musicFeatureIsMajor = "music_feature_is_major"
        case blockedReason = "blocked_reason"
        case trackArtists = "track_artists"
    }
    
}

struct MetaData: Codable {
    
    var total: Int
    var currentPage: Int
    var numPages: Int
    var perPage: Int
    var previous: String?
    var next: String
    
    enum CodingKeys: String, CodingKey {
        case total
        case currentPage = "current_page"
        case numPages = "num_pages"
        case perPage = "per_page"
        case previous
        case next
    }
    
}

struct SongsResponse: Codable {
    var meta: MetaData
    var tracks: [Track]
}
