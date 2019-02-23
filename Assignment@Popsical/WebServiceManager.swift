//
//  WebServiceManager.swift
//  Assignment@Popsical
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebServiceManager {
    
    private let dataSourceURL = "https://api-staging.popsical.tv/v3/songs.json?page="
    static let sharedInstance = WebServiceManager()
    var pageNumber = 1
    
    func fetchSongDetails(forPage pageNum: Int, completionBlock: @escaping (_ songs: [Track]) -> Void, errorBlock: @escaping (_ error: Error?) -> Void) {
        
        var songsArray: [Track] = []
        let url = URL(string: "\(dataSourceURL)\(pageNum)")
        
        Alamofire.request(url!,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return errorBlock(response.error)
                }
                
                let parsedJson = JSON(response.result.value!)
                for (_,jsonObj):(String,JSON) in parsedJson["tracks"] {
                    
                    let releaseDate: Date?
                    if let rldate = self.dateFromString(dateStr: jsonObj["release_date"].stringValue) {
                        releaseDate = rldate
                    }else {
                        releaseDate = nil
                    }
                    
                    let track = Track(id: jsonObj["id"].intValue, number:jsonObj["number"].stringValue, title:jsonObj["title"].stringValue, altTitle:jsonObj["alt_title"].stringValue, runTime:jsonObj["run_time"].intValue, releaseDate:releaseDate, source:jsonObj["source"].stringValue, imageURL:jsonObj["images"]["poster"]["url"].stringValue)
                    
                    songsArray.append(track)
                    
                }
                
                completionBlock(songsArray)
        }
        
    }
    
    func dateFromString(dateStr: String) -> Date? {
        
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFor.date(from: dateStr) ?? nil
        
    }
    
}
