//
//  KKRxSwiftView.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/30.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minLength = 5

class KKRxSwiftView: KKView {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "RxSwift"
        view.textAlignment = .center
        return view
    }()
    
    lazy var accountTextfield: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.init(white: 0.25, alpha: 0.25)
        view.placeholder = "请输入账号..."
        return view
    }()
    
    lazy var accountLabel: UILabel = {
        let view = UILabel();
        view.text = "至少输入\(minLength)字符串"
        return view
    }()
    
    lazy var passwordTextfield: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.init(white: 0.25, alpha: 0.25)
        view.placeholder = "请输入密码..."
        return view
    }()
    
    lazy var passwordLabel: UILabel = {
        let view = UILabel()
        view.text = "请至少输入\(minLength)字符串"
        return view
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("RxSwift", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
   
   
    
    override func kk_setupView() {
        super.kk_setupView()
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview();
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        self.addSubview(accountTextfield)
        accountTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        self.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountTextfield.snp_bottomMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(20)
        }
        
        self.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(accountTextfield.snp.bottom)
        }
        
        self.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextfield.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(accountLabel.snp.height)
        }
        
        
        self.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.height).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
    }
    
    override func kk_bindViewModel() {
        super.kk_bindViewModel()
       
        
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
