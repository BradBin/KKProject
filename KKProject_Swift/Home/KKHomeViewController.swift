//
//  KKHomeViewController.swift
//  KKProject_Swift
//
//  Created by Macbook Pro 15.4  on 2019/4/29.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import SnapKit
import DynamicColor

class KKHomeViewController: KKViewController {
    
    // 懒加载
    private lazy var viewModel : KKHomeViewModel = {
        let viewModel = KKHomeViewModel()
        return viewModel
    }()
    
    // 懒加载
    private lazy var homeView : KKHomeView = {
        
        let view = KKHomeView(viewModel: self.viewModel)
        view.backgroundColor = UIColor.init(hexString: "#78FCA6")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func kk_addSubView(){
        super.kk_addSubView()
        self.view.addSubview(homeView)
        homeView.snp.makeConstraints { (snp) in
            snp.edges.equalToSuperview()
        }
    }
    
    override func kk_bindViewModel() {
        super.kk_bindViewModel()

        
        
   
        
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
