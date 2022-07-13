//
//  TestViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/11.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        testButton.backgroundColor = .red
        testButton.layer.cornerRadius = 10

        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        
    }
}
