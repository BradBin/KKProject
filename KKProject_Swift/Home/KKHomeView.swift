//
//  KKHomeView.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/25.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

class KKHomeView: KKTableView {
    
    override func kk_setupView() {
        super.kk_setupView()
        self.tableView.register(KKHomeViewCell.self, forCellReuseIdentifier: KKHomeCellIdentifier)
    }
    
    override func kk_bindViewModel() {
        super.kk_bindViewModel()
        print(self.viewModel!)
    }
    
    
  

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}



extension KKHomeView{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: KKHomeCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let homeCell = cell as! KKHomeViewCell
        homeCell.nameLabel.text = "index \(indexPath.section)"
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
