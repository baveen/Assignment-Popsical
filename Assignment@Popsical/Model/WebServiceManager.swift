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
    var pageNumber = 0
   // private var songsArray: [Track] = []
    
    func fetchSongDetails(forPage pageNum: Int, completionBlock: @escaping (_ songs: [Track]) -> Void, errorBlock: @escaping (_ error: Error?) -> Void) {
        
        let url = URL(string: "\(dataSourceURL)\(pageNum)")
        
        Alamofire.request(url!,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return errorBlock(response.error)
                }
                
                guard response.result.isSuccess else {
                    return
                }
                
                do {
                    let jsonData = response.data!
                    let res = try JSONDecoder().decode(SongsResponse.self, from: jsonData)
                    completionBlock(res.tracks)

                }
                catch {
                    errorBlock(error)
                }
        }
        
    }
    
}
