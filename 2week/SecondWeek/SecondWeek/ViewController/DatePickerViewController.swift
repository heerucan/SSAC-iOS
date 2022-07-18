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
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
        configureImageView()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        
        for i in 0...3 {
            setupDateLabel(date: selectedDate.addingTimeInterval(TimeInterval((24*60*60*100*(i+1)))), index: i)
        }
    }
    
    func configureDatePicker() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    func configureImageView() {
        dayImageView.forEach { view in
            view.layer.cornerRadius = 10
            view.contentMode = .scaleAspectFill
        }
    }
    
    func setupDateLabel(date: Date, index: Int) {
        dateLabelCollection.forEach { label in
            label.textAlignment = .center
            label.numberOfLines = 2
            label.font = .boldSystemFont(ofSize: 16)
        }
        
        let format = DateFormatter()
        format.dateStyle = .medium
        format.dateFormat = "yyyy년 MM월 dd일"
        format.locale = Locale(identifier: "ko_KR")
        
        dateLabelCollection[index].text = format.string(from: date)
    }
}
