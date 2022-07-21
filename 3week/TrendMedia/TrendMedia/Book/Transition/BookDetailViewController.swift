//
//  BookDetailViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/21.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    static let identifier = "BookDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func webButtonClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Book", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BookWebViewController.identifier) as! BookWebViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
