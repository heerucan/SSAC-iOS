//
//  OverviewTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/05.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        overviewLabel.numberOfLines = 2
        overviewLabel.font = .systemFont(ofSize: 13)
    }
}
