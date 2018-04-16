//
//  BaseViewController.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/3.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit
import ReactiveCocoa

class BaseViewController: UIViewController {

    var rightItemColor : UIColor?
    var testLogin = false
    
        
    // MARK: - 提示页面
    lazy var nodataTipView = NodataTipVC.noDataTipVC(desVC: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    // MARK: - 导航条的UI配置
    func configNavigationBar()
    {
        let backBtn = UIButton(type: .custom)
        weak var weakSelf = self
        backBtn.reactive.controlEvents(.touchUpInside).observe { (obc) in
            weakSelf?.navigationController?.popViewController(animated: true)
        }
        
        if testLogin {//登录
            backBtn.setImage(UIImage.init(named: "nav_icon_back_default"), for: .normal)
            backBtn.setImage(UIImage.init(named: "nav_icon_back_default"), for: .highlighted)
            
            let config = [kCTForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = config as [NSAttributedStringKey : Any]
            let image = UIImage.imageWithColor(color: UIColor.blueThemeColor(), size: CGSize.init(width: UIScreen.main.bounds.width, height: 64))
            navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            backBtn.setImage(UIImage.init(named: "icon_back_default"), for: .normal)
            backBtn.setImage(UIImage.init(named: "icon_back_default"), for: .highlighted)
            let config = [kCTForegroundColorAttributeName:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = config as [NSAttributedStringKey : Any]
            let image = UIImage.imageWithColor(color: UIColor.white, size: CGSize.init(width: UIScreen.main.bounds.width, height: 64))
            navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
           let color = UIColor.color(value: 240.0)
           let size = CGSize.init(width: UIScreen.main.bounds.width, height: 1.0/UIScreen.main.scale)
            
            navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: color, size: size)
        }
       backBtn.contentHorizontalAlignment = .left
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: 58, height: 44)
        let customView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 58, height: 44))
        customView.addSubview(backBtn)
        let backItem = UIBarButtonItem.init(customView: customView)
        navigationItem.leftBarButtonItem = backItem
        
        
    }
    
    func setNaviBarRightItemText(text:String,color:UIColor,sel:Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: text, style: .plain, target: self, action: sel)
        navigationItem.rightBarButtonItem?.tintColor = color
        rightItemColor = color
        
    }
    
    
    func setRightItemEnable(enable:Bool)
    {
        navigationItem.rightBarButtonItem?.isEnabled = enable
        if enable {
            navigationItem.rightBarButtonItem?.tintColor = rightItemColor
        } else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.color(value: 220.0)
        }
    }
    
    func setNaviBarRightItemImage(imageName:String,sel:Selector)
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: imageName), style: .plain, target: self, action: sel)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    // MARK: - 点击事件
    
    func back()
    {
        navigationController?.popViewController(animated: true)
    }

    deinit {
    
        NotificationCenter.default.removeObserver(self)
        print("控制器"+NSStringFromClass(self.classForCoder)+"--------被销毁")
    }
}
