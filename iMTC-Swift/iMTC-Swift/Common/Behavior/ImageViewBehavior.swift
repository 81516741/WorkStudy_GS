//
//  ImageViewBehavior.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/3.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class ImageViewBehavior: Behavior {

    @IBOutlet var imageView : UIImageView!

    override func check() -> Bool {
        return imageView == nil ? false : true
    }
}
