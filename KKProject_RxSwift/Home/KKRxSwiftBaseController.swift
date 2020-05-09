//
//  KKRxSwiftBaseController.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/27.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KKRxSwiftBaseController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var button : UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor = .red
        view.setTitle("button", for: .normal)
        return view
    }()
    
    lazy var textfield: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入..."
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var tapLabel : UILabel = {
        let view = UILabel()
        view.text = "tapLabel"
        view.backgroundColor = .green
        return view
    }()
    
    lazy var person: KKPerson = {
        let p = KKPerson.init(name: "youbin", age: 28)
        return p
    }()
    
     @objc dynamic var user: KKPerson = KKPerson(name: "userName", age: 21)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "RxSwift基础"
        setupView()
        bindViewModel()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() -> Void {
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.scrollView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 100, height: 40))
        }
        
        self.scrollView.addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.top.equalTo(button.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 100, height: 40))
        }
        
        
        self.scrollView.addSubview(tapLabel)
        tapLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.textfield.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 100, height: 50))
        }
        
        self.scrollView.snp.makeConstraints { (make) in
            make.bottom.equalTo(tapLabel.snp.bottom).offset(1000)
        }
        
    }
    
    
    
    
    func bindViewModel() -> Void {
        
        /// 监控scrollView
        self.scrollView.rx.contentOffset.subscribe(onNext: { (contentOffset) in
            print("contentOffset : x \(contentOffset.x) y \(contentOffset.y)")
        })
        
        /// KVO
        self.scrollView.rx.observe(CGPoint.self, "contentOffset").subscribe(onNext: { [weak self] offset in
            var delta = offset!.y / CGFloat(64) + 1
            delta = CGFloat.maximum(delta, 0)
            self?.button.alpha = CGFloat.minimum(delta, 1)
        })
        
        ///textfield文本相应
        self.textfield.rx.text.orEmpty.subscribe(onNext: { (text) in
            print("监控到了: ",text)
        })
        self.textfield.rx.text.bind(to: self.button.rx.title())
        
        ///手势
        let tap = UITapGestureRecognizer()
        self.tapLabel.addGestureRecognizer(tap)
        self.tapLabel.isUserInteractionEnabled = true
        tap.rx.event.subscribe(onNext: { (event) in
            print("手势点击: ",event)
        })
        
        ///通知
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).subscribe { (event) in
            print("通知: ",event)
        }
        
        /// button点击事件
        self.button.rx.tap
            .subscribe(onNext: { [weak self] in
                print("button rx action")
            })
        
        
        /// 观察者
        let d = DisposeBag()
        
        let interval : DispatchTimeInterval = .seconds(1)
        Observable<Int>.interval(interval, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] (_) in
            self.person.age   += 1
            self.person.name! += "~"
            }, onError: { (error) in
                print(error)
            }).disposed(by: d)
        
        person.rx.observeWeakly(Int.self, "age").distinctUntilChanged().subscribe(onNext: { (age) in
            print("KVO observeWeakly age:",age ?? -1)
        }, onError: { (error) in
            print("KVO error:",error)
        })
        
        person.rx.observe(String.self, "name").distinctUntilChanged().subscribe(onNext: { (name) in
            print("KVO observe name:",name ?? "Hello world")
        }, onError: { (error) in
            print(error)
        })
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension KKHomeViewController{
    
}
