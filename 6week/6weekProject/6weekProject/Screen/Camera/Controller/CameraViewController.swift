//
//  CameraViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/12.
//

import UIKit

import YPImagePicker

final class CameraViewController: UIViewController {

    // MARK: - Property
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
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
        
    }
    
    // UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
    }
    
    private func configureLayout() {
        
    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc
    
}
