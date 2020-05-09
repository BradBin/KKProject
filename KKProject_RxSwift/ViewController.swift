//
//  ViewController.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/26.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import DynamicColor

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*************************************
     
     RxSwift的subject子类:
     PublishSubject:
     BehaviorSubject:
     ReplaySubject:
     AsyncSubject:
     
     **************************************/
    
    
    //PublicSubject: 先订阅,后发送
    func publishSubject() -> Void {
        let subject = PublishSubject<Int>()
        subject.onNext(1)
        subject.onNext(2)
        subject.subscribe(onNext: { (result) in
            print("publishSubject : " + "\(result)")
        }, onError: { (error) in
            print("publishSubject :" + "\(error)")
        }, onCompleted: {
            print("publishSubject : onCompleted")
        })
        subject.onNext(3)
        subject.onNext(4)
        subject.onCompleted()
    }
    
    
    
    
    
    //BehaviorSubject:会打印出来订阅前最后的一个消息，以及订阅后发送的消息
    func behaviorSubject() -> Void {
        let subject = BehaviorSubject<Int>(value: 4)
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.subscribe(onNext: { (result) in
            print("behaviorSubject : " + "\(result)")
        }, onError: { (error) in
            print("behaviorSubject :" + "\(error)")
        }, onCompleted: {
            print("behaviorSubject : onCompleted")
        })
        subject.onNext(4)
        subject.onNext(5)
        subject.onNext(6)
        subject.onCompleted()
    }
    
    
    
    ///ReplaySubject:会打印出来订阅前bufferSize个消息，以及订阅后发送的消息
    func replaySubject() -> Void {
        let subject = ReplaySubject<Int>.create(bufferSize: 2)
        subject.onNext(0)
        subject.onNext(1)
        subject.onNext(2)
        subject.subscribe(onNext: { (result) in
            print("replaySubject : " + "\(result)")
        }, onError: { (error) in
            print("replaySubject :" + "\(error)")
        }, onCompleted: {
            print("replaySubject : onCompleted")
        })
        subject.onNext(3)
        subject.onNext(4)
        subject.onNext(5)
        subject.onCompleted()
    }
    
    
    ///AsyncSubject:在收到completed消息后，会打印最后一个消息，在收到error消息后，会移除所有观察者，并返回错误
    func asyncSubject() -> Void {
        
        let subject = AsyncSubject<Int>()
        subject.onNext(0)
        subject.onNext(1)
        subject.onNext(2)
        subject.subscribe(onNext: { (result) in
            print("asyncSubject : " + "\(result)")
        }, onError: { (error) in
            print("asyncSubject :" + "\(error)")
        }, onCompleted: {
            print("asyncSubject : onCompleted")
        })
        subject.onNext(3)
        subject.onNext(4)
        subject.onNext(5)
        subject.onCompleted()
        
    }
    
}


