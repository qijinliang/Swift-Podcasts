//
//  PodcastCell.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/22.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {

    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else { return }
            
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
