//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Property
    
    // http는 App Transport Security Setting을 해주지 않으면 열리지 않는다.
    var destinationURL: String = "https://www.apple.com"

    // MARK: - IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
    
    // MARK: - IBAction
        
    @IBAction func backButtonClicked(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func forwardButtonClicked(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    // MARK: - Custom Method
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - UISearchBarDelegate

extension WebViewController: UISearchBarDelegate {
    // searchBar의 searchButton 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        openWebPage(url: searchBarText)
    }
}
