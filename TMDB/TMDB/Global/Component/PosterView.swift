//
//  PosterView.swift
//  TMDB
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

class PosterView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        let view = UINib(nibName: Nib.poster, bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .clear
        self.addSubview(view)
    }
}
