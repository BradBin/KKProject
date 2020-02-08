//
//  KKTabBarController.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/6.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import ESTabBarController_swift

class KKTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarVC : KKTabBarController = self.createMainVC(tabBarVC: self) as! KKTabBarController
        tabBarVC.delegate = self as? UITabBarControllerDelegate
        // Do any additional setup after loading the view.
    }
    
    
    func createMainVC(tabBarVC : UITabBarController) -> UITabBarController {
        
        let homeVC = KKHomeViewController()
        let videoVC = KKVideoViewController()
        let postVC = KKPostViewController()
        let messageVC = KKMessageViewController()
        let profileVC = KKProfileViewController()
        
        homeVC.tabBarItem = ESTabBarItem.init(KKTabBarItemContentView(), title: "Home", image: R.image.home_normal(), selectedImage: R.image.home_highlight())
        videoVC.tabBarItem = ESTabBarItem.init(KKTabBarItemContentView(), title: "video", image: R.image.fishpond_normal(), selectedImage: R.image.fishpond_highlight())
        postVC.tabBarItem = ESTabBarItem.init(KKTabBarItemCircleContentView(), title: "post", image: R.image.post_normal(), selectedImage: R.image.post_highlight())
        messageVC.tabBarItem = ESTabBarItem.init(KKTabBarItemContentView(), title: "message", image: R.image.message_normal(), selectedImage: R.image.message_highlight())
        profileVC.tabBarItem = ESTabBarItem.init(KKTabBarItemContentView(), title: "profile", image: R.image.account_normal(), selectedImage: R.image.account_highlight())
        
        
        tabBarVC.viewControllers        = [homeVC,videoVC,postVC,messageVC,profileVC]
        tabBarVC.tabBar.backgroundColor = UIColor.init(hexString: "#EAF1FD")
        tabBarVC.tabBar.isTranslucent   = true
        tabBarVC.tabBar.backgroundImage = UIImage()
        tabBarVC.tabBar.shadowImage     = UIImage()
        
        return tabBarVC
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
