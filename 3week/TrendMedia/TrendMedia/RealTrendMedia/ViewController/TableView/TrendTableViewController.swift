//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func movieButtonClicked(_ sender: UIButton) {
        
        // 버킷리스트 테이블뷰에 present
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        vc.moviePlaceholder = sender.titleLabel?.text
        self.present(vc, animated: true)
    }

    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.moviePlaceholder = sender.titleLabel?.text
        self.present(vc, animated: true)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        vc.moviePlaceholder = sender.titleLabel?.text
        self.present(nav, animated: true)
        
    }
}
