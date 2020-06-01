//
//  customPageView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/25/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardPage: UIView {
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
         label.font = UIFont.systemFont(ofSize: 11)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var imageView: UIView = {
        let imageView = UIView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func set(style: SwiftyOnboardStyle) {
        switch style {
        case .light:
            title.textColor = .lightGray
            subTitle.textColor = .lightGray
        case .dark:
            title.textColor = .lightGray
            subTitle.textColor = .lightGray
        }
    }
    
    func setUp() {
        self.addSubview(imageView)
        
        let margin = self.layoutMarginsGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 70).isActive = true
        imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -70).isActive = true
        imageView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 40).isActive = true
        imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5).isActive = true
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 80).isActive = true
        title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -80).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 80).isActive = true
        subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -80).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
