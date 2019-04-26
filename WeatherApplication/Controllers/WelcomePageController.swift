//
//  WelcomePageController.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 23/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import UIKit

class WelcomePageController: UIPageViewController {

    //MARK: - Properties
    private var welcomes = [WelcomeHelper]()
    private var imageView: UIImageView!
    private var arrayImage = [String]()
    private let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        createImageView()
        createButton()
        createPageControl()
        createConstraints()
    }
    
    fileprivate func fetchData() {
        let weatherName = WelcomeHelper(name: "Актуальные данные",
                                        text1: "Всегда под рукой и легко в использовании",
                                        text2:" бесплатно и безопасно. ")
        
        let weatherFast = WelcomeHelper(name: "Детализация данных",
                                        text1: "Множество погодных данных",
                                        text2: " у вас в руке. ")
        
        let weatherRain = WelcomeHelper(name: "Состояние погоды",
                                        text1: "Характеристика погоды",
                                        text2: " на протяжении всего дня. ")
        
        let weatherCold = WelcomeHelper(name: "Кастомизация интерфейса",
                                        text1: "Настраивайте приложение под ваши нужды",
                                        text2:" в несколько кликов.")
        
        arrayImage = ["sunset", "park","rain","weather"]
        
        welcomes.append(weatherName)
        welcomes.append(weatherFast)
        welcomes.append(weatherRain)
        welcomes.append(weatherCold)
    }
    
    //MARK: - UIPageControl
    fileprivate func createPageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
    }
    
    //MARK: - Button
    fileprivate func createButton() {
        startButton.backgroundColor = UIColor(red: 45/255,
                                              green: 165/255,
                                              blue: 225/255, alpha: 1)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.tintColor = .white
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.setTitle("Начать", for: .normal)
        startButton.layer.cornerRadius = 17
        startButton.layer.masksToBounds = true
        startButton.addTarget(self, action: #selector(nextView), for: .touchUpInside)
    }
    
    @objc fileprivate func nextView() {
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "Main") as! HomeController
        self.present(VC, animated: true, completion: nil)
    }
    
    //MARK: - Init
    fileprivate func createImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "sunset")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    
    
    lazy var subWiew: [UIView] = [self.imageView, self.startButton]
    
    //MARK: - NSLayout
    func createConstraints() {
        
        for view in subWiew { self.view.addSubview(view)}
        
        guard let imageConstraint = imageView else { return }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageConstraint,
                               attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 150),

            NSLayoutConstraint(item: imageConstraint,
                               attribute: .centerX, relatedBy: .equal,
                               toItem: view, attribute: .centerX,
                               multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: imageConstraint,
                               attribute: .top, relatedBy: .equal,
                               toItem: view, attribute: .top,
                               multiplier: 1, constant: view.bounds.size.height / 4),
            
            
            ])
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: startButton,
                               attribute: .leading, relatedBy: .equal,
                               toItem: view, attribute: .leading,
                               multiplier: 1, constant: 90),
            
            NSLayoutConstraint(item: startButton,
                               attribute: .trailing, relatedBy: .equal,
                               toItem: view, attribute: .trailing,
                               multiplier: 1, constant: -90),
            
            NSLayoutConstraint(item: startButton,
                               attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 40),
            
            NSLayoutConstraint(item: startButton,
                               attribute: .top, relatedBy: .equal,
                               toItem: imageConstraint, attribute: .bottom,
                               multiplier: 1, constant: 220)
            ])
    }
    
    //MARK: - Create VC
    lazy private var welcomeViewController: [WelcomeViewController] = {
        var welcomeVC = [WelcomeViewController]()
        for welcome in welcomes {
            welcomeVC.append(WelcomeViewController(welcomeWith: welcome))
        }
        return welcomeVC
    }()
    
    //MARK: - init UIPageVC
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        view.backgroundColor = .white

        dataSource = self
        delegate = self
        
        setViewControllers([welcomeViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension
extension WelcomePageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewVC = viewController as? WelcomeViewController else { return nil }
        if let index = welcomeViewController.firstIndex(of: viewVC) {
            
            UIView.animate(withDuration: 1, animations: {
                self.imageView.image = UIImage(named: self.arrayImage[index])
            })
            
            if index > 0 {
                return welcomeViewController[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewVC = viewController as? WelcomeViewController else { return nil }
        if let index = welcomeViewController.firstIndex(of: viewVC) {
            UIView.animate(withDuration: 1, animations: {
                self.imageView.image = UIImage(named: self.arrayImage[index])
            })
            
            if index < welcomes.count - 1 {
                return welcomeViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return welcomes.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
