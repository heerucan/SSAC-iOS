//
//  LottoViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/09/01.
//

import UIKit

class LottoViewController: UIViewController {
    
    var viewModel = LottoViewModel()

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 서버 통신을 3초 뒤에 할 것이다~
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
        bindData()
    }
    
    func bindData() {
        viewModel.number1.bind { num in
            self.label1.text = "\(num)"
        }
        
        viewModel.number2.bind { num in
            self.label2.text = "\(num)"
        }
        
        viewModel.number3.bind { num in
            self.label3.text = "\(num)"
        }
        
        viewModel.number4.bind { num in
            self.label4.text = "\(num)"
        }
        
        viewModel.number5.bind { num in
            self.label5.text = "\(num)"
        }
        
        viewModel.number6.bind { num in
            self.label6.text = "\(num)"
        }
        
        viewModel.number7.bind { num in
            self.label7.text = "\(num)"
        }
        
        viewModel.lottoMoney.bind { num in
            self.dateLabel.text = "\(num)"
        }
    }

}
