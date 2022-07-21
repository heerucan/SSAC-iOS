//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    static let identifier = "BucketListTableViewController"
    
    var list = ["헤어질 결심", "탑건", "범죄도시2"]
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 80
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        list.append("마녀")
        list.append("겨울")
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !value.isEmpty,
            (2...6).contains(value.count) {
            list.append(value)
            myTableView.reloadData()
        } else {
            
        }
        
        // 또는 
        guard let value = sender.text else { return }
        list.append(value)
        myTableView.reloadData()
        
        //reloadSections - 특정 섹션만 리로드할 때
//        myTableView.reloadSections(IndexSet(), with: .automatic)
        
        //reloadRows - 특정 로우만 리로드할 때 / 내가 즐겨찾기한 섹션만 리로드하고 싶을 때!
        // 여러개를 한 번에 갱신해야 하기 때문에 [IndexPath]라는 배열을 받고,
//        myTableView.reloadRows(at: [IndexPath(row: 0, section: 0),
//                                    IndexPath(row: 1, section: 0)],
//                               with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        return cell
    }
    
    // 편집이 가능한 상태
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // canEditRowAt 메소드가 있어야 editingStyle 메소드가 작동한다.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RecommendCollectionViewController.identifier) as! RecommendCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
