//
//  DatePickerViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/13.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet var dayImageView: [UIImageView]!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
        configureImageView()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    func configureImageView() {
        dayImageView.forEach { view in
            view.layer.cornerRadius = 10
            view.contentMode = .scaleAspectFill
            
        }
    }

}
