//
//  HureeActivityViewController.swift
//  HureeUIFrameWork
//
//  Created by heerucan on 2022/08/16.
//

import UIKit

extension UIViewController {
    public func hureeShowActivityViewController(shareImage: UIImage,
                                                shareURL: String,
                                                shareText: String) {
        
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText],
                                                      applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail, .print]
        self.present(viewController, animated: true)
    }
}
