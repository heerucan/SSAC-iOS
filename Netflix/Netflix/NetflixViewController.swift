//
//  NetflixViewController.swift
//  Netflix
//
//  Created by heerucan on 2022/07/08.
//

import UIKit

class NetflixViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var frozenImageView: UIImageView!
    @IBOutlet weak var aladinImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        [frozenImageView, aladinImageView, avatarImageView].forEach { view in
            view?.layer.borderColor = UIColor.yellow.cgColor
            view?.layer.borderWidth = 2
            view?.clipsToBounds = true
            view?.layer.cornerRadius = view!.frame.width / 2
        }
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        [backgroundImageView, frozenImageView, aladinImageView, avatarImageView].forEach { view in
            view?.image = UIImage(named: "movie\(Int.random(in: 1...5))")
        }
    }
}
