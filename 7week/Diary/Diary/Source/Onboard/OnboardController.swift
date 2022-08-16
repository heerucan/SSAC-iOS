//
//  OnboardController.swift
//  Diary
//
//  Created by heerucan on 2022/08/16.
//

import UIKit

import HureeUIFrameWork

class OnboardViewController: UIPageViewController {

    // MARK: - Property
    
    // 뷰컨트롤러 배열
    var pageViewControllerList: [UIViewController] = []

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        createPageViewController()
        configurePageViewController()
    }
    
    // MARK: - Configure UI & Layout
    
    // 배열에 뷰컨트롤러 추가
    private func createPageViewController() {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier) as! FirstViewController
        let vc2 = storyboard.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier) as! SecondViewController
        let vc3 = storyboard.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as! ThirdViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        
        // display first pageViewController & set
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension OnboardViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 이전
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 페이지뷰컨에 보이는 뷰컨의 인덱스를 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        // 왜 1을 빼주냐면, beforeIndex를 가져와야 하기 때문에 -> 0,1,2 있으면 2번 기준으로 1번을 보여주는 것
        let previousIndex = viewControllerIndex - 1 // -1
        
        // 0보다 작은 인덱스는 없으니까 nil이고, 그게 아니라면 리스트에서 가져오는 것
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    // 이후
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        // nextIndex가 리스트보다 값이 크면 가져올 수 없으니까 nil이다.
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    // pageControl 보여주기
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // display된 컨트롤러의 인덱스를 가져오는 것 / 근데 없을 경우에 0을 리턴
        guard let first = viewControllers?.first,
              let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
}

