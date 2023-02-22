//
//  APIService.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/22.
//

import Foundation
import Alamofire
import FeedKit


class APIService {
    
    typealias EpisodeDownloadCompleteTuple = (fileUrl: String, episodeTitle: String)
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {

        
        let parameters = ["term": searchText, "media": "podcast"]
        
    
        
        AF.request(baseiTunesSearchURL, method: .get, parameters: parameters, headers: nil).responseData  { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }

            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }

        }
        
    
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
}
