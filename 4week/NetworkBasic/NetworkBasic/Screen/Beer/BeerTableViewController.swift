//
//  BeerTableViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/02.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

final class BeerTableViewController: UITableViewController {
    
    var beerList: [BeerModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAPI()
    }
    
    func requestAPI() {
        
        let url = EndPoint.beerURL2
        
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for beer in json.arrayValue {
                    
                    let name = beer["name"].stringValue
                    let image = beer["image_url"].stringValue
                    let description = beer["description"].stringValue
                    
                    let data = BeerModel(name: name, image: image, description: description)
                    self.beerList.append(data)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        let beerIndexPath = beerList[indexPath.row]
        cell.beerLabel.text = beerIndexPath.name
        cell.descriptionLabel.text = beerIndexPath.description
        cell.beerImageView.kf.setImage(with: URL(string: beerIndexPath.image))
        return cell
    }
}
