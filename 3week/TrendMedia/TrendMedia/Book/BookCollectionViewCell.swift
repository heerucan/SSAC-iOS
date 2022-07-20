//
//  BookCollectionViewCell.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    func configureUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.masksToBounds = false
    }
    
    func configureCell(data: Book) {
        let url = URL(string: data.image)
        bookLabel.text = data.title
        bookImageView.kf.setImage(with: url)
        rateLabel.text = data.rate
        backView.backgroundColor = data.color
    }
}
