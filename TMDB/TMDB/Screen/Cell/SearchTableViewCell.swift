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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        contentView.makeShadow()
        backView.makeRound()
        posterImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        overviewLabel.numberOfLines = 1
        posterImageView.contentMode = .scaleAspectFill
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        guard let convertDate = dateFormatter.date(from: date) else { return "" }
        return dateFormatter.string(from: convertDate)
    }
  
    public func setData(data: Movie) {
        dateLabel.text = data.date
        tagLabel.text = data.genre
        posterImageView.kf.setImage(with: data.image)
        rateNumberLabel.text = "\(round(data.rate*10)/10)"
        titleLabel.text = data.title
        overviewLabel.text = data.overview  
    }
}
