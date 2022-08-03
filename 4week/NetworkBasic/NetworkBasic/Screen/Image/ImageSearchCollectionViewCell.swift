//
//  ImageSearchCollectionViewCell.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

class ImageSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
}
