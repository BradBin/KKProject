//
//  KKRxSwiftView.swift
//  KKProject
//
//  Created by youbin on 2020/4/24.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import RxSwift

class KKRxSwiftView: KKView {
    
    public var viewModel : KKRxSwiftViewModel?
    
    required init(viewModel: KKViewModelProtocol?) {
        self.viewModel = viewModel as? KKRxSwiftViewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func kk_setupView() {
        super.kk_setupView()
        self.backgroundColor = .white
    }
    
    override func kk_bindViewModel() {
        super.kk_bindViewModel()
        
        
        /***************************************
         RxSwift中的四种subject
         ***************************************/
        //        asyncSubject()
        //
        //        publishSubject()
        
        //        behaviorSubject()
        
        replaySubject()
    }
    
    
    
    /// asyncSubject:只接收最新的一次信号
    func asyncSubject() -> Void {
        let subject = AsyncSubject<String>()
        subject.onNext("AsyncSubject : 123") //发送信号
        subject.onNext("AsyncSubject : 124") //发送信号
        subject.subscribe(onNext: { (result) in
            print(result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("AsyncSubject onCompleted")
        })
        subject.onNext("AsyncSubject : 125") //发送信号
        subject.onCompleted()
    }
    
    
    ///PublishSubject:先订阅后发送,才能收到消息
    func publishSubject() -> Void {
        let subject = PublishSubject<String>()
        //        subject.onNext("publishSubject : 123")
        subject.subscribe(onNext: { (result) in
            print(result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("publishSubject onCompleted")
        })
        subject.onNext("publishSubject : 124")
        subject.onNext("publishSubject : 125")
        subject.onCompleted()
    }
    
    
    /// BehaviorSubject
    /***************************************
     BehaviorSubject和PublishSubject唯一的区别:
     就是只要有人订阅,它就会向订阅者发送最新的一次事件信号
     ****************************************/
    func behaviorSubject() -> Void {
        let subject = BehaviorSubject<String>(value: "RxSwift step by step")
        subject.subscribe(onNext: { (result) in
            print("1. " + result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("1. behaviorSubject onCompleted")
        })
        subject.onNext("behaviorSubject : 125")
        subject.subscribe(onNext: { (result) in
            print("2. " + result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("2. behaviorSubject onCompleted")
        })
        subject.onCompleted()
    }
    
    
    
    ///ReplaySubject
    /********************************************
     ReplaySubject的行为和BehaviorSubject类似，都会给订阅者发送历史消息。不同地方有两点：
     
     ReplaySubject没有默认消息，订阅空的ReplaySubject不会收到任何消息；
     ReplaySubject自带一个缓冲区，当有订阅者订阅的时候，它会向订阅者发送缓冲区内的所有消息；
     *********************************************/
    func replaySubject() -> Void {
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.subscribe(onNext: { (result) in
            print("1. " + result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("1. replaySubject onCompleted")
        })
        subject.onNext("replaySubject 123")
        subject.onNext("replaySubject 124")
        subject.onNext("replaySubject 125")
        subject.subscribe(onNext: { (result) in
            print("2. " + result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("2. replaySubject onCompleted")
        })
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
