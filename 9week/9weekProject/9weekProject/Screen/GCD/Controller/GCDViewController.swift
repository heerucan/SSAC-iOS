//
//  GCDViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    
    var imageList: [UIImage] = []
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var nasaImage: UIImageView!
    @IBOutlet weak var nasaImage2: UIImageView!
    @IBOutlet weak var nasaImage3: UIImageView!
    
    @IBOutlet var imageCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - 동기 / 직렬
    
    @IBAction func serialSync(_ sender: UIButton) {
        print("1️⃣ Start - serialSync")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        DispatchQueue.main.sync {
            print("1️⃣⭐️ DispatchQueue - serialSync")
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("1️⃣ End - serialSync")
    }
    
    // MARK: - 동기 / 직렬
    
    @IBAction func serialAsync(_ sender: UIButton) {
        print("2️⃣ Start - serialAsync")
        
        DispatchQueue.main.async {
            print("2️⃣⭐️ DispatchQueue - serialAsync")
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("2️⃣ End - serialAsync")
    }
    
    // MARK: - 동기 / 동시
    // 여러명한테 보내더라도 이 보내는 작업이 끝나기 전까지 다른 작업 수행X
    
    @IBAction func globalSync(_ sender: UIButton) {
        print("3️⃣ Start - globalSync")
        
        DispatchQueue.global().sync {
            print("3️⃣⭐️ DispatchQueue - globalSync")
            
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("3️⃣ End - globalSync")
        
    }
    
    // MARK: - 비동기 / 동시
    
    @IBAction func globalAsync(_ sender: UIButton) {
        print("4️⃣ Start - globalAsync", Thread.isMainThread)
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print("4️⃣⭐️ DispatchQueue - globalAsync", Thread.isMainThread)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("4️⃣ End - globalAsync", Thread.isMainThread)
    }
    
    
    // MARK: - Global Quality of Service
    
    @IBAction func qos(_ sender: UIButton) {
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print("🔰 Start : background")
                print(i, terminator: " ")
                print("//// End : background 🔰")

            }
        }
        
        
        for i in 201...300 {
            DispatchQueue.global(qos: .userInteractive).async {
                print("🔰 Start : userInteractive")
                print(i, terminator: " ")
                print("//// End : userInteractive 🔰")

            }
        }
        
        
        for i in 401...500 {
            DispatchQueue.global(qos: .utility).async {
                print("🔰 Start : utility")
                print(i, terminator: " ")
                print("//// End : utility 🔰")

            }
        }
    }
    
    
    // MARK: - DispatchGroup
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            print("🔰 Start : 1...100 /// ")
            for i in 1...100 {
                print(i, terminator: " ")
            }
            print(" /// End : 1...100 🔰 ")
        }
        
        DispatchQueue.global().async(group: group) {
            print("🔰 Start : 201...300 /// ")
            for i in 201...300 {
                print(i, terminator: " ")
            }
            print(" /// End : 201...300 🔰 ")
        }
        
        DispatchQueue.global().async(group: group) {
            print("🔰 Start : 301...400 /// ")
            for i in 301...400 {
                print(i, terminator: " ")
            }
            print(" /// End : 301...400 🔰 ")
        }
        
        group.notify(queue: .main) {
            print("🔰끝!!갱신하자!!🔰")
        }
        
    }
    
    
    // MARK: - DispatchGroup을 큰 사이즈의 Nasa 이미지를 3번 가져와보자
    
    @IBAction func nasaDispatchGroupButton(_ sender: UIButton) {
                
//        request(url: url1) { image in
//            print("🦋 1 🦋")
//        }
//
//        request(url: url2) { image in
//            print("🦋 2 🦋")
//        }
//
//        request(url: url3) { image in
//            print("🦋 3 🦋")
//        }
        
        // 순서대로 해주기 위해서 위 코드보다 좀 더 오래 걸림
//        request(url: url1) { image in
//            print("🦋 1 🦋")
//            self.request(url: self.url2) { image in
//                print("🦋 2 🦋")
//                self.request(url: self.url3) { image in
//                    print("🦋 3 🦋")
//                    print("끝, 갱신!")
//                }
//            }
//        }
        
        // DispatchGroup을 사용해서 좀 더 발전시켜보자!
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("🦋 1 🦋")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("🦋 2 🦋")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("🦋 3 🦋")
            }
        }
        
        group.notify(queue: .main) {
            print("끝, 갱신!")
        }
    }
    
    
    
    // MARK: - DispatchGroup : 그룹 내 코드가 비동기인 경우 - Enter/Leave
    
    @IBAction func nasaEnterLeaveDispatchGroupButton(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            group.enter() // RC +1
            self.request(url: self.url1) { image in
                self.imageList.append(image!)

                print("🦋 1 🦋")
                group.leave() // RC -1
            }
        }
        
        DispatchQueue.global().async(group: group) {
            group.enter()
            self.request(url: self.url2) { image in
                self.imageList.append(image!)

                print("🦋 2 🦋")
                group.leave()
            }
        }
        
        DispatchQueue.global().async(group: group) {
            group.enter()
            self.request(url: self.url3) { image in
                self.imageList.append(image!)

                print("🦋 3 🦋")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("끝, 갱신!")
            self.nasaImage.image = self.imageList[0]
            self.nasaImage2.image = self.imageList[1]
            self.nasaImage3.image = self.imageList[2]
        }
    }
    
    
    
    
    // MARK: - 교착상태
    
    @IBAction func raceCondition(_ sender: Any) {
        let group = DispatchGroup()
        
        var nickname = "Ruhee"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "후리방구"
            print("첫번째:", nickname)
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "소깡스"
            print("두번째:", nickname)
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "태끼새키"
            print("세번째:", nickname)
        }
        
        group.notify(queue: .main) {
            print("결과", nickname)
        }
    }
    
    
    
    
    // MARK: - Network
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            DispatchQueue.main.async {
                self.nasaImage.image = UIImage(data: data)
                completionHandler(self.nasaImage.image)
            }
            
        }.resume()
    }
}
