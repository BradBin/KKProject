//
//  KKHomeViewController.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/26.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import DynamicColor

class KKHomeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    lazy var rxswiftList: [String]? = {
        let data = ["RxSwift基础", "RxSwift之Observeable"]
        return data
    }()
    
    lazy var rxswiftListView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell.Identifier")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "RxSwift"
        
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() -> Void {

        self.view.addSubview(rxswiftListView)
        rxswiftListView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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




extension KKHomeViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rxswiftList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell.Identifier", for: indexPath)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell.Identifier")
            
        }
        cell?.textLabel?.text = self.rxswiftList?[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(KKRxSwiftBaseController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(KKObserveableController(), animated: true)
        default:
            self.navigationController?.pushViewController(KKRxSwiftBaseController(), animated: true)
        }
    }
    
}

