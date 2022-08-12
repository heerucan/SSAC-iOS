//
//  CameraViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import YPImagePicker

final class CameraViewController: UIViewController {

    // MARK: - Property
    
    // UIImagePickerController1. 인스턴스 생성
    let picker = UIImagePickerController()
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupImagePicker()
    }
    
    // MARK: - @IBAction
    
    // OpenSource
    @IBAction func YPImagePickerButtonClicked(_ sender: UIButton) {
        
        let picker = YPImagePicker()
        // 사진을 고르고 나서 실행되는 클로저 구문
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera, "이미지 소스 - 카메라/라이브러리") // Image source (camera or library)
                print(photo.image, "최종적으로 사용자가 선택한 사진") // Final image selected by the user
                print(photo.originalImage, "원본 이미지") // original image selected by the user, unfiltered
                print(photo.modifiedImage, "수정된 이미지") // Transformed image, can be nil
                print(photo.exifMeta, "원본 이미지의 메타 데이터")
                
                self.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    // UIImagePickerController
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 사용자에게 토스트/얼럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = true // 사진 편집 유무
        present(picker, animated: true)
    }
    
    // UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 사용자에게 토스트/얼럿")
            return
        }
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // 사진 편집 유무
        present(picker, animated: true)
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Custom Method
    
    private func setupImagePicker() {
        // UIImagePickerController2. 델리게이트 위임처리
        picker.delegate = self
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        // 이미지를 선택하고 무엇을 할 건가?에 관한 매개변수
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("🥳사진 저장했다")
        }
    }
    
    // 이미지뷰 > 네이버 > 얼굴 분석 요청 > 응답!
    // 문자열이 아닌 파일, 이미지, PDF 파일 자체가 그대로 전송되지 않는다. 텍스트 형태로 인코딩을 해야 한다!
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        /* 어떤 파일의 종류가 서버에게 전달이 되는지 명시하는 게 필요하고,
         이걸 Content-Type이라고 한다.
         이 친구는 헤더에 보통 추가해서 작업한다.*/
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data",
                                   "X-Naver-Client-Id": APIKey.NAVER_ID,
                                   "X-Naver-Client-Secret": APIKey.NAVER_KEY]
        
        // UIImage를 텍스트 형태 (바이너리 타입)로 변환해서 전달
        guard let imageData = imageView.image?.pngData() else { return }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
            .validate(statusCode: 200..<400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - @objc
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
// UIImagePickerController3. - 네비게이션 컨트롤러를 상속받고 있음
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UIImagePickerController4. - 사진을 선택하거나, 카메라 촬영하고 나면 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function, "🦋 사진선택하거나, 카메라 촬영 직후")
        
        /* 원본, 편집, 메타 데이터 등 - infoKey,
         그리고 타입은 Any로 명확하게 지정되지 않았다.
         왜냐하면 메타 데이터는 명확하기 않기 때문에 그래서 타입캐스팅이 필요한 부분이다. */
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
            dismiss(animated: true)
        }
    }
    
    // UIImagePickerController5. - 취소 버튼을 누르면 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function, "🦋 취소버튼 클릭 시")
    }
}
