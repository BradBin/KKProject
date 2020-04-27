//
//  KKRxSwiftViewController.swift
//  KKProject
//
//  Created by youbin on 2020/4/24.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

class KKRxSwiftViewController: KKViewController {
  

    public lazy var rxViewModel : KKRxSwiftViewModel = {
       let viewModel = KKRxSwiftViewModel()
        return viewModel
    }()
    
    public lazy var rxView : KKRxSwiftView = {
        let view : KKRxSwiftView = KKRxSwiftView(viewModel: self.rxViewModel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift"

        // Do any additional setup after loading the view.
    }
    
    
       override func kk_addSubView(){
           super.kk_addSubView()
        self.view.addSubview(rxView)
           rxView.snp.makeConstraints { (snp) in
               snp.edges.equalToSuperview()
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
