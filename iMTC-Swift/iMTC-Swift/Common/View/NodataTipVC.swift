//
//  NodataTipVC.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/3.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class NodataTipVC: UIViewController {

    @IBOutlet var reloadBtn:UIButton!
    var hander:((_ tipView : NodataTipVC) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadBtn.layer.cornerRadius = 2.0
        reloadBtn.clipsToBounds = true
        reloadBtn.layer.borderWidth = 1.0
        reloadBtn.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func clickReloadBtn(btn :UIButton) {
        hander?(self)
    }
    
    func hide()
    {
        view.isHidden = true
    }
    
    func show(handerIn:@escaping ((_ tipView: NodataTipVC) -> Void))
    {
        view.isHidden = false
        hander = handerIn
    }
    
    class func noDataTipVC(desVC:UIViewController)->NodataTipVC
    {
        let tipVC = NodataTipVC()
        tipVC.view.frame = desVC.view.bounds
        tipVC.view.isHidden = true
        desVC.addChildViewController(tipVC)
        desVC.view.addSubview(tipVC.view)
        desVC.view.bringSubview(toFront: tipVC.view)
        return tipVC
    }
    
    deinit
    {
        print("------NodataTipVC------被销毁");
    }

}
