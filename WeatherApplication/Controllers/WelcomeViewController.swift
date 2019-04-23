//
//  WelcomeViewController.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 23/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    //MARK: - Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subView: [UIView] = [self.nameLabel, self.textLabel1, self.textLabel2]
    
    
    
    //MARK: - Init
    init(welcomeWith: WelcomeHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        nameLabel.text = welcomeWith.name
        textLabel1.text = welcomeWith.text1
        textLabel2.text = welcomeWith.text2
        
        for view in subView { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: nameLabel,
                               attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 30),
            
            NSLayoutConstraint(item: nameLabel,
                               attribute: .top, relatedBy: .equal,
                               toItem: view, attribute: .top,
                               multiplier: 1, constant: view.bounds.size.height / 2 ),
            
            NSLayoutConstraint(item: nameLabel,
                               attribute: .centerX, relatedBy: .equal,
                               toItem: view, attribute: .centerX,
                               multiplier: 1, constant: 0),
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textLabel1,
                               attribute: .top, relatedBy: .equal,
                               toItem: nameLabel, attribute: .bottom,
                               multiplier: 1, constant: 10),
            
            NSLayoutConstraint(item: textLabel1,
                               attribute: .centerX, relatedBy: .equal,
                               toItem: view, attribute: .centerX,
                               multiplier: 1, constant: 0),
            
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textLabel2,
                               attribute: .top, relatedBy: .equal,
                               toItem: textLabel1, attribute: .bottom,
                               multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: textLabel2,
                               attribute: .centerX, relatedBy: .equal,
                               toItem: view, attribute: .centerX,
                               multiplier: 1, constant: 0),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
