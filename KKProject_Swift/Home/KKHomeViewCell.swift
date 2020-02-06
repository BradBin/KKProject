//
//  KKHomeViewCell.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import Foundation

let KKHomeCellIdentifier = "KK.Home.Cell.Identitifer"

class KKHomeViewCell: KKTableViewCell {
    
    
    lazy var nameLabel : UILabel = {
       let view = UILabel()
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func kk_setupView() {
        super.kk_setupView()
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 8, bottom: 5, right: 8))
        }
    }

}
