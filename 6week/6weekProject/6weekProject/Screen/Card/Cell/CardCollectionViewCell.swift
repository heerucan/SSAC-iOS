//
//  CardCollectionViewCell.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI를 여기에 작성하면 성능적으로 좋음
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.contentLabel.text = nil
    }
    
    func configureUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.contentMode = .scaleAspectFill
        cardView.posterImageView.backgroundColor = .clear
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
}
