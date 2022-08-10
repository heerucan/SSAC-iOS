//
//  WebViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/07.
//

import UIKit

import WebKit

final class WebViewController: UIViewController {

    // MARK: - Property
    
    public var movieID = 0
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestVideo(movieID: movieID)
    }
    
    // MARK: - @IBAction
    
    @IBAction func closeBarButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBarButtonClicked(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func ForwardBarButtonClicked(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshBarButtonClicked(_ sender: Any) {
        webView.reload()
    }
    
    // MARK: - InitUI
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Custom Method
    
    func openWebView(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - Network

extension WebViewController {
    func requestVideo(movieID: Int) {
        VideoManager.shared.requestVideo(movieID: movieID) { link in
            let detinationURL = "https://www.youtube.com/watch?v=\(link)"
            DispatchQueue.main.async {
                self.openWebView(url: detinationURL)
            }
        }
    }
}
