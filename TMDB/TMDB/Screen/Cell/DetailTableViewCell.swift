//
//  DetailTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/05.
//

import UIKit

import Kingfisher

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        castImageView.makeRound()
        castImageView.contentMode = .scaleAspectFill
        castImageView.backgroundColor = .lightGray
        subLabel.textColor = .lightGray
        subLabel.font = .systemFont(ofSize: 13)
    }
    
    func setData(data: Cast) {
        castImageView.kf.setImage(with: data.image)
        nameLabel.text = data.name
        subLabel.text = data.castName + " / " + data.character
    }
}
