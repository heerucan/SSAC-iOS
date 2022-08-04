//
//  DetailTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/05.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configureUI() {
        castImageView.makeRound()
        subLabel.textColor = .lightGray
        subLabel.font = .systemFont(ofSize: 13)
    }
    
    func setData() {
        
    }
}
