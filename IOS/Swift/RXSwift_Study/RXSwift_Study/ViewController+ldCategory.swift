//
//  ViewController+ldCategory.swift
//  RXSwift_Study
//
//  Created by lingda on 2018/7/6.
//  Copyright © 2018年 lingda. All rights reserved.
//
import UIKit

extension  ViewController {
     func rxConfig() {
        btn1.rx.tap.subscribe(onNext: {
            print("我被点击了😀")
        }).disposed(by: disposeBag)
        
        scrollView.rx.contentOffset.subscribe(onNext: {contentOffet in
            print(contentOffet)
        }).disposed(by:disposeBag)
        
    NotificationCenter.default.rx.notification(Notification.Name(rawValue: "nihao")).subscribe({(notification) in
            print("ddd")
        }).disposed(by:disposeBag)
        
    }
}

extension ViewController {
     func sessionRequest() {
        guard let url = URL(string: "http://service.tunnel.qydev.com/ldapp/test") else {
            return
        }
        
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .subscribe(onNext: { data in
                print("Data Task Success with count: \(data.count)")
            }, onError: { error in
                print("Data Task Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
