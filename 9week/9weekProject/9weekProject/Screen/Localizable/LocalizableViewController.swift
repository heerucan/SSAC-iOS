//
//  LocalizableViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/09/06.
//

import UIKit

import CoreLocation
import MessageUI // 메일로 문의 보내기, 디바이스만 가능

class LocalizableViewController: UIViewController,
                                 MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizable()
        //        requestLocation()
    }
    
    
    func setupLocalizable() {
        navigationItem.title = "navigation_title".localized
        searchBar.placeholder = "search_placeholder".localized
        myLabel.text = "introduce".localized(with: "후리")
        inputTextField.text = "number_test".localized(with: 25)
        inputTextField.placeholder = "main_age_placeholder".localized
        sampleButton.setTitle("common_cancel".localized, for: .normal)
    }
    
    func requestLocation() {
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            // 메일보내기
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["iwpow@naver.com"])
            mail.setSubject("앱 문의사항 관련 메일이다.")
            mail.mailComposeDelegate = self
            self.present(mail, animated: true, completion: nil)
        } else {
            // alert, 메일 등록을 해주거나 iwpow~@naver.com으로 문의주세요
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("메일 쓰다가 취소")
        case .saved:
            print("메일 쓰다가 임시저장")
        case .sent:
            print("메일 보낸 것")
        case .failed:
            print("오류로 인해 메일 보내기 실패")
        @unknown default:
            fatalError()
        }
        controller.dismiss(animated: true)
    }
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized<T>(with: T) -> String {
        return String(format: self.localized, with as! CVarArg)
    }
}
