//
//  ShoppingTableViewCell.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickedStarButton(_ sender: Any) {
    }
}
