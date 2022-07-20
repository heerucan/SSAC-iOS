//
//  TrendViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/19.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        searchTextField.borderColor()
    }

}
