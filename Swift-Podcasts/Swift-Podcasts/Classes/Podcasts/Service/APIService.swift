//
//  APIService.swift
//  Swift-Podcasts
//
//  Created by 金亮 on 2023/2/22.
//

import Foundation
import Alamofire
import FeedKit

extension Notification.Name {
    static let downloadProgress = NSNotification.Name("downloadProgress")
    static let downloadComplete = NSNotification.Name("downloadComplete")
}

class APIService {
    
    typealias EpisodeDownloadCompleteTuple = (fileUrl: String, episodeTitle: String)
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    static let shared = APIService()
    
    func downloadEpisode(episode: Episode) {
        
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        
        AF.download(episode.streamUrl, to: downloadRequest).downloadProgress { (progress) in
            
            NotificationCenter.default.post(name: .downloadProgress, object: nil, userInfo: ["title": episode.title, "progress": progress.fractionCompleted])
            
        }.response{ (resp) in

            let episodeDownloadComplete = EpisodeDownloadCompleteTuple(fileUrl: resp.description, episode.title)
            NotificationCenter.default.post(name: .downloadComplete, object: episodeDownloadComplete, userInfo: nil)
            
            var downloadedEpisodes = UserDefaults.standard.downloadedEpisodes()
            guard let index = downloadedEpisodes.firstIndex(where: { $0.title == episode.title && $0.author == episode.author }) else { return }
            downloadedEpisodes[index].fileUrl = resp.description
            
            do {
                let data = try JSONEncoder().encode(downloadedEpisodes)
                UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
            } catch let err {
                print("Failed to encode downloaded episodes with file url update:", err)
            }
            
        }
    }
    
    
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                switch feed {
                case .atom(_):
                    break
                case let .rss(feed):
                    let episodes = feed.toEpisodes()
                    completionHandler(episodes)
                    break
                case .json(_):
                    break
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
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
