//
//  MapViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/11.
//

import UIKit
import MapKit

/*
 Location1. 모듈 추가
 */

import CoreLocation

/*
 MapView
 - 지도와 위치 권한은 상관없다.
 - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해줘야 함
 - 중심, 범위 지정
 - 핀(어노테이션)
 */

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Property
    
    let center = CLLocationCoordinate2D(latitude: 48.858264, longitude: 2.294240)
    
    // Location2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupMap(center: center)
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRequestLocationServiceAlert()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Custom Method
    
    private func setupMap(center: CLLocationCoordinate2D) {
        
        // 지도 중심 설정 : 애플맵 활용해 좌표 복사
        let center = center
        
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // 지도에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "🦋내위치🦋"
        
        mapView.addAnnotation(annotation)
    }
    
    // Location3. 프로토콜 연결
    private func setupLocation() {
        locationManager.delegate = self
    }
}

// MARK: - User Defined Method

// 위치 관련된 User Defined Method
extension MapViewController {
    
    /*
     Location7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
     그러니까 이 부분이 환경설정 -> 개인 정보 보호 -> 위치 서비스가 켜져있다면 요청이 가능하고,
     꺼져 있다면 custom alert으로 상황을 알려줘야 한다.
     꺼져 있으면 어떤 앱에서도 위치 서비스를 사용하고 있지 않는 상황이고,
     사용자가 이 위치 서비스를 사용하고 있지 않는 걸 사용자도 모르고 있을 수 있기 때문이다.
     - notDetermined : 아직 고르지 않은 상태
     - denied : 허용 안함 / 설정에서 추후에 거부한 상태 / 위치 서비스 자체를 나중에 비활성화함 / 비행기 모드
     - restricted : 앱에서 권한 자체가 없는 경우 ex. 자녀 보호 기능 같은 걸로 아예 제한
     - authorizedAlways : 항상 허용
     - authorizedWhenInUse : 앱을 사용할 때만 허용
     */
    
    func checkUserDeviceLocationServiceAuthorization() {
        print(#function, "디바이스 체크한당!")
        let authorizationStatus: CLAuthorizationStatus
        
        // 버전에 따라 나눠주는 이유는 deprecated 이슈 때문
        if #available(iOS 14.0, *) {
            // 인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            // locationManager는 CLLocationManager()의 인스턴스이고, 아래는 타입 프로퍼티이다.
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 활성화 여부 체크
        // 해당 메소드가 위치 서비스 여부를 체크해준다.
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            showRequestLocationServiceAlert()
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
    
    /* Location8. 사용자의 위치 서비스가 활성화된 것을 확인 후, 그 다음 위치 권한 상태 확인
     사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인
     (단, 사전에 iOS 위치 서비스 활성화 꼭 확인
     */
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            
            /*
             1. kCLLocationAccuracyBest : 각각의 기기에 맞는 위치 정확도를 알아서 해줌
             2. 앱을 사용하는 동안에 위치 권한을 요청
             -> 단, plist에 WhenInUse가 등록되어야 해당 request~ 메소드를 사용할 수 있다.
             */
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메소드가 실행된다.
            locationManager.startUpdatingLocation()
            
        default: print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용",
                                                            message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.",
                                                            preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

// MARK: - CLLocationManagerDelegate

// Location4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    // Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations, "사용자 위치 잘 가져온 경우")
        
        // ex. 위도, 경도 기반으로 날씨 정보를 조회
        // ex. 지도를 다시 세팅
        if let coordinate = locations.last?.coordinate {
            setupMap(center: coordinate)
        }
        
        // 위치 업데이트 멈추기
        locationManager.stopUpdatingLocation()
    }
    
    // Location6. 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "사용자 위치 못 가져온 경우")
    }
    
    /* Location9. 사용자의 권한 상태가 바뀔 때를 알려줌
     거부했다가 설정에서 변경했거나, 혹은 notDetermined 에서 허용을 했거나 등
     허용 했어서 위치를 가지고 오는 중에 설정에서 거부하고 들어온다면??
     */
    // iOS 14 이상: 사용자의 권한 상태가 변경이 될 때, 위치 관리자 생성할 때도 호출됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "사용자의 권한 상태가 변경될 때!, checkUserDevice함수도 불러라!")
        checkUserDeviceLocationServiceAuthorization()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    // 지도에 커스텀 핀 추가
    /*
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
     }
     */
}
