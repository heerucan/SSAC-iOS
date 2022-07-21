//
//  BookSearchViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/21.
//

import UIKit

class BookSearchViewController: UIViewController {
    
    static let identifier = "BookSearchViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(closeButtonClicked))
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
