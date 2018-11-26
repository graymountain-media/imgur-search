//
//  ImageTableViewCell.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    let customImageView: CustomImageView = {
        let view = CustomImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        
        self.addSubview(customImageView)
        self.addSubview(titleView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        customImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        customImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func updateCellWith(title: String, image: UIImage) {
        self.titleLabel.text = title
        self.customImageView.image = image
    }
    
    override func prepareForReuse() {
        customImageView.image = nil
    }

}
