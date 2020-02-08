//
//  KKView.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/25.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

class KKView: UIView, KKViewProtocol{
    
    var viewModel : KKViewModelProtocol?
    
    init(viewmodel : KKViewModelProtocol) {
        super.init(frame: CGRect.zero)
        viewModel = viewmodel
        kk_setupView()
        kk_bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func kk_setupView() {
        
    }
    
    func kk_bindViewModel() {
        
    }

    /*
     // Only ov@objc e@objc rride draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
