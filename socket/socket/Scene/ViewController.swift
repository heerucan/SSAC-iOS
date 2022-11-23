//
//  ViewController.swift
//  socket
//
//  Created by heerucan on 2022/11/22.
//

import UIKit
import Alamofire

/// scrollToBottom
/// pagenation + database
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentTextField: UITextField!
    
    // var dummy: [String] = []
    var chat: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummyChat()
        
        fetchChats()
        configureTableView()
        
        // on sesac으로 받은 이벤트를 처리하기 위한 NotificationCenter
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getMessage(notification:)),
            name: Notification.Name("getMessage"),
            object: nil)
    }
    
    // 왜 이 메소드에서 소켓 연결을 끊냐면, 뒤로 백제스처를 완벽히 해서 뷰가 사라지는 시점에 끊어줘야 하니까
    // disappear는 백제스처 하는 도중에 이전 뷰가 보이는 상태에도 호출되기 때문
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        // dummy.append(contentTextField.text ?? "")
        // tableView.reloadData()
        // tableView.scrollToRow(at: IndexPath(row: chat.count - 1, section: 0), at: .bottom, animated: false)
        // contentTextField.text?.removeAll()
        
        postChat(text: contentTextField.text ?? "")
    }
    
    @objc func getMessage(notification: NSNotification) {
            
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let userID = notification.userInfo!["userId"] as! String
        
        let value = Chat(text: chat, userID: userID, name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, ID: "")
        
        self.chat.append(value)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let data = dummy[indexPath.row]
        let data = chat[indexPath.row]
         
//        if indexPath.row.isMultiple(of: 2) {
        // userID라는 식별자가 나랑 같으면 내 셀에, 다르면 다른사람셀에
        if data.userID == APIKey.userId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            cell.chatLabel.text = data.text
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            cell.chatLabel.text = data.text
            cell.profileNameLabel.text = data.name
            return cell
        }
    }
    
}

extension ViewController {
    
    // private func dummyChat() {
    //     dummy = ["안녕하세요", "반갑습니다", "별명이 왜 고래밥인가요?", "세상에서\n고래밥 과자가 젤\n맛있더라구요", "아..."]
    // }
    
    private func fetchChats() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]

        AF.request(APIKey.url, method: .get, headers: header).responseDecodable(of: [Chat].self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.chat = value
                self?.tableView.reloadData()
                self?.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0), at: .bottom, animated: false)
                
                // 여기 쓰는 이유는 이전 채팅들도 처리해줘야 하니까
                SocketIOManager.shared.establishConnection()
                
            case .failure(let error):
                print("FAIL", error)
            }
        }
    }
    
    private func postChat(text: String) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]
        AF.request(APIKey.url,
                   method: .post,
                   parameters: ["text": text],
                   encoder: JSONParameterEncoder.default,
                   headers: header).responseString { data in
            print("POST CHAT SUCCEED", data)
        }
    }
}
