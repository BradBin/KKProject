//
//  KKProfileViewController.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/20.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

class KKProfileViewController: KKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let rxSwiftButton : UIButton  = UIButton.init(type: .custom)
        rxSwiftButton.backgroundColor = .red
        rxSwiftButton.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rxSwiftButton)
    
        
      
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(KKRxSwiftViewController(), animated: true)
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
