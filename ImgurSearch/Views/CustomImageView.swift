//
//  CustomImageView.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/22/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import AlamofireImage

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    override var image: UIImage? {
        didSet {
            if image != nil {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 15).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage(withUrlString urlString: String) {
        
        image = nil
        
        activityIndicator.startAnimating()
        if let url = URL(string: urlString) {
            self.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2))
        }
        
    }

}
