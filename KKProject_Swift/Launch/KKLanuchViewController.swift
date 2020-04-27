//
//  KKLanuchViewController.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/3.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import Rswift

class KKLanuchViewController: KKViewController {
    
    lazy var launchImgV: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = R.image.launchImage()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(launchImgV)
        launchImgV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.kk_enterTabBar()
        }
        
        // Do any additional setup after loading the view.
    }
    
    /// 进入主界面
    func kk_enterTabBar() -> Void {
        let app : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let navVC : KKNavigationController = KKNavigationController.init(rootViewController: KKTabBarController())
        app.window?.rootViewController = navVC
        UIView.transition(with: app.window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
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
