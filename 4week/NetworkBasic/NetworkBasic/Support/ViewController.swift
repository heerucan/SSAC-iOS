//
//  ViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

class ViewController: UIViewController, RuheeTableViewProtocol, ViewPresentableProtocol {
    
    var navigationTitleString: String = "루희의 다마고치"
    
    var backgroundColor: UIColor = .blue
    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    func numberOfRowsInSection() -> Int {
        return 2
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
