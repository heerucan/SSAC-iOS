//
//  RecommendCollectionViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

import Kingfisher
import Toast

/*
 TableView -> CollectionView
 Row -> Item
 heightForRow -> FlowLayout (heightForRow)
 */

class RecommendCollectionViewController: UICollectionViewController {
    
    static let identifier = "RecommendCollectionViewController"
    
    var imageURL = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA2MjBfMjg1%2FMDAxNjU1NzI3MTk1ODA3.ED4Enwxy9cLt_KWG9VQZDmYMfcv6sxOZfChWkFns0W4g.aZm2h8SUIGvLvUG3gO8nnX8FC5tyXswS1UXABDfg-kgg.JPEG.yunhsy%2Fsearch.pstatic.jpg&type=a340"

    @IBOutlet var recommendCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 컬렉션뷰의 셀 크기, 셀 사이의 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)

        // 셀이 가지고 있는 크기
        layout.itemSize = CGSize(width: width/3, height: width/3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        // horizontal일 때는 좌우사이의 간격 / vertical일 때는 상하사이의 간격
        layout.minimumLineSpacing = spacing
        // horizontal일 때는 상하사이의 간격
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
        cell.posterImageView.backgroundColor = .brown
        let url = URL(string: imageURL)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    // cell 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 왜 view일까? 그건 그냥 uiview가 깔려 있는 게 아니라 애플이 이름을 view로 명칭해뒀으니까..
        self.view.makeToast("\(indexPath.item)번 째 셀을 선택했당!", duration: 1.0, position: .center)
        self.navigationController?.popViewController(animated: true)
    }
}
