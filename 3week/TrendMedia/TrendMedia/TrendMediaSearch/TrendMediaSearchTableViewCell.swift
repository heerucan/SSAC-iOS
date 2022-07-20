//
//  TrendMediaSearchTableViewCell.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

class TrendMediaSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!
    
    func configureCell(data: Movie) {
        movieTitleLabel.font = .boldSystemFont(ofSize: 15)
        movieTitleLabel.text = data.title
        dateLabel.text = "\(data.releaseDate) | \(data.runtime) | \(data.rate)"
        storyLabel.text = data.overview
        storyLabel.numberOfLines = 0
    }

}
