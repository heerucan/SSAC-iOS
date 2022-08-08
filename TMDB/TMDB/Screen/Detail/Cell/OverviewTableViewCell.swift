//
//  OverviewTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/05.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    public var isExpand = false
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    
    public func configureUI() {
        overviewLabel.numberOfLines = isExpand ? 0 : 2
        overviewLabel.font = .systemFont(ofSize: 13)
        
        let buttonImage = isExpand
        ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        downButton.setImage(buttonImage, for: .normal)
    }
}
