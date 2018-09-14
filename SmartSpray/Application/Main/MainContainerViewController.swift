//
//  MainViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/14/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

protocol MainContainerViewControllerDelegate {
    func outerScrollViewShouldScroll() -> Bool
}

class MainContainerViewController: UIViewController {

    var leftVC: UIViewController!
    var middleVC: UIViewController!
    var rightVC: UIViewController!
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        return scroll
    }()
    
    var initialContentOffset = CGPoint()
    var delegate: MainContainerViewControllerDelegate?
    
    
    class func containerViewWith(leftVC: UIViewController, middleVC: UIViewController, rightVC: UIViewController) -> MainContainerViewController {
        let container = MainContainerViewController()
        container.leftVC = leftVC
        container.middleVC = middleVC
        container.rightVC = rightVC
        return container
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHorizontalScrollView()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let loginButton = UIButton(type: .custom)
        loginButton.setImage(UIImage.init(named: "login-50"), for: .normal)
        
        let loginBarItem = UIBarButtonItem(customView: loginButton)
        loginBarItem.customView?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loginBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive =  true
        
        navigationItem.rightBarButtonItem = loginBarItem
        
        navigationController?.navigationBar.barTintColor = UIColor.SmartSpray.yellow
        
//        let logoImageView = UIImageView(image: UIImage(named: "navBarLogo"))
//        logoImageView.contentMode = .scaleAspectFit
//
//        navigationController?.navigationBar.topItem?.titleView = logoImageView

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.init(name: "Open Sans", size: 100)], for: UIControlState.normal)
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
    }
    
    func setHorizontalScrollView() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        scrollView.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: layoutGuide.layoutFrame.width, height: layoutGuide.layoutFrame.height)
        view.addSubview(scrollView)
        
        let scrollWidth = 3 * layoutGuide.layoutFrame.width
        let scrollHeight = layoutGuide.layoutFrame.height
        scrollView.contentSize = CGSize(width: scrollWidth, height: 0)
        
        leftVC.view.frame = CGRect(x: 0, y: 0, width: layoutGuide.layoutFrame.width, height: layoutGuide.layoutFrame.height - (navigationController?.navigationBar.frame.height)!)
        middleVC.view.frame = CGRect(x: layoutGuide.layoutFrame.width, y: 0, width: layoutGuide.layoutFrame.width, height: layoutGuide.layoutFrame.height - (navigationController?.navigationBar.frame.height)!)
        rightVC.view.frame = CGRect(x: 2 * layoutGuide.layoutFrame.width, y: 0, width: layoutGuide.layoutFrame.width, height: layoutGuide.layoutFrame.height - (navigationController?.navigationBar.frame.height)!)
        
        addChildViewController(leftVC)
        addChildViewController(middleVC)
        addChildViewController(rightVC)
        
        scrollView.addSubview(leftVC.view)
        scrollView.addSubview(middleVC.view)
        scrollView.addSubview(rightVC.view)
        
        leftVC.didMove(toParentViewController: self)
        middleVC.didMove(toParentViewController: self)
        rightVC.didMove(toParentViewController: self)
        
        scrollView.contentOffset.x = middleVC.view.frame.origin.x
        scrollView.delegate = self
    }
}

extension MainContainerViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.initialContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.convert(middleVC.view.frame.origin, to: self.view).x)
        if abs(scrollView.convert(middleVC.view.frame.origin, to: self.view).x) >= view.frame.width / 2 {
            if scrollView.convert(middleVC.view.frame.origin, to: self.view).x < 0 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Prediction List", style: UIBarButtonItemStyle.done, target: nil, action: nil)
            }
            else {
                navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Capture", style: UIBarButtonItemStyle.done, target: nil, action: nil)
            }
        }
        else if abs(scrollView.convert(middleVC.view.frame.origin, to: self.view).x) <= view.frame.width / 2 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Predict", style: UIBarButtonItemStyle.done, target: nil, action: nil)
        }
    }
}
