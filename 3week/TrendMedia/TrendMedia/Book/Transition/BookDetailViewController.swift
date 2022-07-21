//
//  BookDetailViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/21.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    static let identifier = "BookDetailViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func webButtonClicked(_ sender: Any) {

            let sb = UIStoryboard(name: "Book", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BookWebViewController.identifier) as! BookWebViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
