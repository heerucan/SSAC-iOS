//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/02.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(label: nameLabel)
        configureUI(label: imageLabel)
        configureUI(label: descriptionLabel)
    }
    
    func configureUI(label: UILabel) {
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    @IBAction func recommendButtonClicked(_ sender: UIButton) {
        requestApi()
        print("눌럿니?")
    }
    
    func requestApi() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                // NAME
                
                let name = json[0]["name"].stringValue
                self.nameLabel.text = name
                
                // IMAGE_URL
                
                let image = json[0]["image_url"].stringValue
                self.imageLabel.text = image
                self.imageView.image = UIImage(named: image)
                self.imageView.kf.setImage(with: URL(string: image))

                // DESCRIPTION
                
                let description = json[0]["description"].stringValue
                self.descriptionLabel.text = description
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
