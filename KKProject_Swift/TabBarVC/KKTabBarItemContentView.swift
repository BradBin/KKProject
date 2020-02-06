//
//  KKTabBarItemContentView.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/6.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import ESTabBarController_swift

class KKTabBarItemContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 0.6, alpha: 1)
        iconColor = UIColor.init(white: 0.6, alpha: 1)
        
        highlightTextColor = UIColor.init(red: 0.4, green: 0.2, blue: 0.5, alpha: 1)
        highlightIconColor = UIColor.init(red: 0.4, green: 0.2, blue: 0.5, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
