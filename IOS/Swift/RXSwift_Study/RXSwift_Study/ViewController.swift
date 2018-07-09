//
//  ViewController.swift
//  RXSwift_Study
//
//  Created by lingda on 2018/7/6.
//  Copyright © 2018年 lingda. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn1)
        view.addSubview(scrollView)
        rxConfig()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sessionRequest()
    }
    
    func test(a:(_ str:String) throws -> Void) {
        
    }
    //MARK:- lazy load
    lazy var btn1: UIButton = {
        let btn1 = UIButton(frame: CGRect(x: 20, y: 20, width: 50, height: 30))
        btn1.backgroundColor = UIColor.red
        btn1.setTitle("点我", for: .normal)
        return btn1
    }()
    lazy var disposeBag = DisposeBag()
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 20, y: 55, width: 100, height: 100))
        scrollView.backgroundColor = UIColor.lightGray
        scrollView.contentSize = CGSize(width: 100, height: 200)
        return scrollView
    }()
}


