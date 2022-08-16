//
//  ContentTableViewCell.swift
//  TMDB
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        configureCollectionView()
    }
    
    private func configureUI() {
        categoryLabel.font = .systemFont(ofSize: 15)
        categoryLabel.text = "인기 콘텐츠"
    }
    
    private func configureCollectionView() {
        contentCollectionView.collectionViewLayout = collectionViewLayout()
        contentCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return layout
    }
}
