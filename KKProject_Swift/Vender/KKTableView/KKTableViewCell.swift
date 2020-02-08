//
//  KKTableViewCell.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit



class KKTableViewCell: UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        kk_setupView()
        kk_bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func kk_setupView() {
        
    }
    
    func kk_bindViewModel() {
        
    }
    
}
