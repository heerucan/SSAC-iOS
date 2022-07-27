//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {
    
    // MARK: - Property
    
    static let identifier = "BucketListTableViewController"
    
    // list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신해줘야 한다
    // 테이블뷰 갱신을 didSet에서 신경써주면 시점에 대한 고려를 해주지 않아도 된다.
    // 딕셔너리에서 키는 중복이 불가능해서 bool값은 key가 될 수 없다.
    // 딕셔너리로 할 경우 순서가 없어서 IndexPath..? 사용 불가..
    var list = [Todo(title: "범죄도시", done: false),
                Todo(title: "탑건", done: false),
                Todo(title: "외계+인", done: false),
                Todo(title: "닥터스트레인지", done: false),
                Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData() // 테이블뷰 전체가 갱신되는 경우가 아니라면 적합하지 않을 수 있따.
//            print("list가 변경됨 \(oldValue) -> \(list)")
        }
    }
    
    var movieInfo = MovieInfo()
    
    var moviePlaceholder: String? = "플레이스홀더"
    
    // MARK: - IBOutlet
    
    // @IBOutlet은 ViewDidLoad 실행 전에 nil / !nil인지 알 수 있다.
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.textColor = .blue
            textField.textAlignment = .center
            textField.textAlignment = .center
            print("didset호출됨") // 한 번만 호출되는 이유는 클래스 객체라서 필요한 시점에 불려지는 것임
        }
    }
    
    @IBOutlet var myTableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 80
        navigationItem.title = "버킷리스트"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "처음으로",
            style: .plain,
            target: self,
            action: #selector(resetButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked))
        textField.placeholder = moviePlaceholder
    }
    
    // MARK: - @objce
    
    // 처음으로 돌아가는 버튼
    @objc func resetButtonClicked() {
        
        //iOS13+ SceneDelegate 쓸 때 동작하는 코드
        
        // 앱을 다시 처음으로 켠 것처럼 만든다. scene들이 연결되어 있는 것 중에 하나를 가져와라.
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MyViewController") as! MyViewController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupCheckButton(_ sender: UIButton) {
        print(#function, "버튼클릭", sender.tag)

        // 배열 인덱스를 찾아서 done을 바꿔야 한다. 그리고 테이블 뷰를 갱신해야 한다.
        list[sender.tag].done = !list[sender.tag].done
        
//        tableView.reloadData()
        
        // tableView.reloadData를 통해서 하는 건 비효율적이기 때문에 체크한 그 row만 갱신해줄 수 있는 함수를 사용한다.
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        // 재사용 셀 오류 코드
        // sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
    
    // MARK: - @IBAction
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        //        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines),
        //            !value.isEmpty,
        //            (2...6).contains(value.count) {
        //            list.append(value)
        //            myTableView.reloadData()
        //        } else { }
        //
                // 또는
                guard let value = sender.text else { return }
                list.append(Todo(title: value, done: false))
        //        myTableView.reloadData()
                
                //reloadSections - 특정 섹션만 리로드할 때
        //        myTableView.reloadSections(IndexSet(), with: .automatic)
                
                //reloadRows - 특정 로우만 리로드할 때 / 내가 즐겨찾기한 섹션만 리로드하고 싶을 때!
                // 여러개를 한 번에 갱신해야 하기 때문에 [IndexPath]라는 배열을 받고,
        //        myTableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .automatic)
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }
        
        // UI적인 요소는 cellForRow에서 해주고, 데이터는 외부에서 처리해줄 것, 그래서 cell 파일에서 ui를 처리해주게 될 것임
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        cell.checkButton.tag = indexPath.row
        let value = list[indexPath.row].done ? "checkmark.circle.fill" : "checkmark.circle"
        cell.checkButton.setImage(UIImage(systemName: value), for: .normal)
        cell.checkButton.addTarget(self, action: #selector(touchupCheckButton(_:)), for: .touchUpInside)
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
//            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RecommendCollectionViewController.identifier) as! RecommendCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 추가
        vc.movieData?.title = list[indexPath.row].title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
