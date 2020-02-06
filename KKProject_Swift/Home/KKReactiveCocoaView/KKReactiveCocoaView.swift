//
//  KKReactiveCocoaView.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/28.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit


class KKReactiveCocoaView: KKView {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "ReactiveCocoa"
        view.textAlignment = .center
        return view
    }()
    
    lazy var accountTextfiled : UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.orange
        view.placeholder = "请输入测试..."
        return view
    }()
    
    lazy var passwordTextfiled : UITextField = {
           let view = UITextField()
           view.backgroundColor = UIColor.orange
           view.placeholder = "请输入密码..."
           return view
       }()
    
    lazy var accountTextView : UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.25)
        view.text = "请输入文本..."
        return view
    }()
    
    
    lazy var submitButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("登录", for: .normal)
        button.backgroundColor = UIColor.init(red: 0.06, green: 0.29, blue: 0.64, alpha: 0.8)
        button.isEnabled = false
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
        
        self.addSubview(accountTextfiled)
        accountTextfiled.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(30)
        }
        
        self.addSubview(passwordTextfiled)
        passwordTextfiled.snp.makeConstraints { (make) in
            make.top.equalTo(accountTextfiled.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(accountTextfiled.snp.height)
        }
        
        
        
        self.addSubview(accountTextView)
        accountTextView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextfiled.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(100)
        }
        
        self.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(accountTextView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(40)
        }
        
        
    }
    
    
    
    
    override func kk_bindViewModel() {
        super.kk_bindViewModel()
        print(self.viewModel ?? KKHomeViewModel.self)
        
        accountTextfiled.reactive.continuousTextValues.observeValues { (text) in
            print(" accountTextfiled " + text)
        }
        
        accountTextfiled.reactive.continuousTextValues.filter { (text) -> Bool in
            return text.trimmingCharacters(in: .whitespacesAndNewlines).count <= 5
        }.observeValues { (text) in
            print(" accountTextfiled filter " + text)
        }
        
        accountTextView.reactive.continuousTextValues.observeValues { (text) in
            print(" accountTextView " + text)
        }
        
        submitButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            print("   -------    ",button)
        }
        
        
        /// 信号的组合
         let accountSignal = accountTextfiled.reactive.continuousTextValues.map { (text) -> Bool in
            return text.trimmingCharacters(in: .whitespacesAndNewlines).count > 3
        }
        let passwordSignal = passwordTextfiled.reactive.continuousTextValues.map { (text) -> Bool in
            return text.trimmingCharacters(in: .whitespacesAndNewlines).count > 3
        }
        
       
        
        
        
        
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}




