//
//  LocationViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/12.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    // MARK: - Property
    
    let rightBarButton = UIBarButtonItem(title: "Filter",
                                      style: .plain,
                                      target: self,
                                      action: #selector(touchupRightButton))
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
//        navigationItem.leftBarButtonItem = lef
    }
    
    private func configureLayout() {
        
    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc
    
    @objc func touchupRightButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megaboxAction = UIAlertAction(title: "메가박스", style: .default) { action in
            print("메가박스")
        }
        
        let lotteAction = UIAlertAction(title: "롯데시네마", style: .default) { action in
            print("롯데시네마")
        }
        
        let cgvAction = UIAlertAction(title: "CGV", style: .default) { action in
            print("CGV")
        }
        
        let allAction = UIAlertAction(title: "전체보기", style: .default) { action in
            print("전체보기")
        }
        
        let cancelAction = UIAlertAction(title: "취소하기", style: .cancel)
        
        alertController.addAction(megaboxAction)
        alertController.addAction(lotteAction)
        alertController.addAction(cgvAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}
