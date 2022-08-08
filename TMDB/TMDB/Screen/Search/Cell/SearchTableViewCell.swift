//
//  SearchTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Kingfisher

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    public func configureUI() {
        contentView.makeShadow()
        backView.makeRound()
        posterImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        overviewLabel.numberOfLines = 1
        posterImageView.contentMode = .scaleAspectFill
    }

    public func setData(data: Movie) {
        dateLabel.text = data.date.toDate()?.toString()
        tagLabel.text = "#Movie" // data.genre
        posterImageView.kf.setImage(with: data.backImage)
        rateNumberLabel.text = "\(round(data.rate*10)/10)"
        titleLabel.text = data.title
        overviewLabel.text = data.overview
    }
}
