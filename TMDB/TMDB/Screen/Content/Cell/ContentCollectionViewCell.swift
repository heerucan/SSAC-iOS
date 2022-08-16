//
//  ContentCollectionViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterView: PosterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        posterView.backgroundColor = .systemGray6
        posterView.posterImageView.contentMode = .scaleAspectFill
    }
}
