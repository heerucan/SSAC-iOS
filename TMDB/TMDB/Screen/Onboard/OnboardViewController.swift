//
//  OnboardViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/17.
//

import UIKit

final class OnboardViewController: UIPageViewController {

    // MARK: - Property
    
    private var pageViewList: [UIViewController] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        appendViewController()
        configurePageViewController()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func appendViewController() {
        let storyboard = UIStoryboard(name: Storyboard.onboard, bundle: nil)
        guard let first = storyboard.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier)
                as? FirstViewController else { return }
        guard let second = storyboard.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier)
                as? SecondViewController else { return }
        guard let third = storyboard.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier)
                as? ThirdViewController else { return }
        pageViewList = [first, second, third]
    }
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        guard let first = pageViewList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension OnboardViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        return previousIndex < 0 ? nil : pageViewList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        return nextIndex >= pageViewList.count ? nil : pageViewList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = pageViewList.firstIndex(of: first) else { return 0 }
        return index
    }
}
