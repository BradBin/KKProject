//
//  KKObserveableController.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/27.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class KKObserveableController: UIViewController {

    let disposeBag = DisposeBag()
    
    lazy var password: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入..."
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.text = "字符串无效"
        view.numberOfLines = 0
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        self.view.backgroundColor = .white
        self.title = "Observeable"
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupView() -> Void {
        
        self.view.addSubview(password)
        password.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(124)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom)
            make.centerX.equalTo(password.snp.centerX)
            make.width.equalTo(password.snp.width)
        }
        
    }
    
    
    
    
    func bindViewModel() -> Void {
        
        let passwordValid = self.password.rx.text.orEmpty.asObservable().map { $0.count >= 6 }
        let observer = textLabel.rx.isHidden
        
        passwordValid.subscribeOn(MainScheduler.instance).observeOn(MainScheduler.instance).bind(to: observer)
        
        
        
        
        obEmpty()
        
        obJust()
        
        obOf()
        
        obFrom()
        
        obDeferred()
        
    }
    
    
    
    /****************Observeable序列*********************/
    

    ///创建空序列  empty函数
    func obEmpty() {
        let ob = Observable<Int>.empty()
        ob.subscribe(onNext: { (num) in
            print("empty 订阅:",num)
        }, onError: { (error) in
            print("empty 错误:",error)
        }, onCompleted: {
            print("empty 完成回调")
        }) {
            print("empty 释放回调")
        }
    }
    
    
    
    //Just:创建单个信号序列,默认来初始化,构建一个只有一个元素的Observable队列,订阅完成自动complete
    func obJust() -> Void {
        let  array = ["youbin", "俊哲"]
        Observable<[String]>.just(array).subscribe { (event) in
            print("Just :",event)
        }.disposed(by: disposeBag)
        
        Observable<[String]>.just(array).subscribe(onNext: { (num) in
            print("just onNext:",num)
        }, onError: { (error) in
            print("just error:",error)
        }, onCompleted: {
            print("just 完成回调")
        }) {
            print("just 释放回调")
        }
    }
    

    /// of:创建新的可观察实例,该实例具有可变数量的元素(必须是同类型)
    func obOf() -> Void {
            ///多个元素 -- 针对序列处理
        Observable<String>.of("youbin","梦琪").subscribe { (event) in
            print("of:",event)
        }.disposed(by: disposeBag)
        
        
        ///字典
        Observable<[String : Any]>.of(["name":"youbin","age":28]).subscribe { (event) in
            print("of :",event)
        }.disposed(by: disposeBag)
    
        
        ///数组
        Observable<[String]>.of(["you", "bin"]).subscribe { (event) in
            print("of 数组:",event)
        }.disposed(by: disposeBag)
        
    }
    
    
      ///from:将可选序列转换为可观察序列
    func obFrom() -> Void {
        Observable<[String]>.from(optional: ["you", "bin"]).subscribe { (event) in
            print("from :",event)
        }.disposed(by: disposeBag)
    }
    
    
    
    
///deferred:返回一个可观察序列,该序列在新观察者订阅时调用指定的工厂函数
    func obDeferred() -> Void {
        var isAdd = true
        Observable<Int>.deferred { () -> Observable<Int> in
            isAdd = !isAdd
            if isAdd {
                return Observable.of(1, 3, 5, 7, 9)
            }
            return Observable.of(0, 2, 4, 6, 8)
        }.subscribe { (event) in
            print("deferred :",event)
        }
        
        
        
        
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
