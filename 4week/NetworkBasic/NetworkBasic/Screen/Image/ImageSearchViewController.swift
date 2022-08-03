//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

final class ImageSearchViewController: UIViewController {
    
    // MARK: - Property
    
    var imageList: [String] = []
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
        fetchImage()
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        let width = UIScreen.main.bounds.width / 3
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        imageCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.identifier)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    // MARK: - Network
    
    func fetchImage() {
        
        // 한글이 안되는 경우 : utf-8로 인코딩 하기 때문에 내부 처리가 필요함
        guard let text = "우영우".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
        
        // Header : 메타정보
        // Body : 실질적인 데이터
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_SEARCH_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SEARCH_KEY
        ]
       
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for image in json["items"].arrayValue {
                    let image = image["link"].stringValue
                    self.imageList.append(image)
                }
                self.imageCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.identifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.kf.setImage(with: URL(string: imageList[indexPath.item]))
        return cell
    }
}
