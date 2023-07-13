//
//  InstrumentsViewController.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/22.
//

import UIKit

/**
 乐器选择界面
 */
class InstrumentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    //MARK: - 变量
    private let InstrumentsCellID = "InstrumentsCellID"
    
    private lazy var backButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(popPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "乐器选择"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private lazy var tableview:UITableView = {
        let tableview = UITableView(frame: view.frame, style: .insetGrouped)
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(InstrumentsCell.self, forCellReuseIdentifier: InstrumentsCellID)
        tableview.backgroundColor = BackgroundColor
        return tableview
    }()
    
    private lazy var plistManager:PlistManager = PlistManager.shared
    
    private var quickFunction:[String]{
        var arr = ["隐藏【木鱼2】音效","隐藏所有音效","展示所有音效"]
        if !styles[0]{
            arr[0] = "显示【木鱼2】音效"
        }
        return arr
    }
    
    private let QuickFunctionID = "QuickFunctionID"
    
    private var styles:[Bool]{
        plistManager.loadSettingStyles()
    }
}

//MARK: - UI
extension InstrumentsViewController{
    func initView(){
        view.backgroundColor = BackgroundColor
        //注册cell
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(tableview)
        initLayout()
    }
    
    func initLayout(){
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(24)
            make.top.equalTo(view).offset(16)
            make.width.equalTo(12)
            make.height.equalTo(23)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(backButton)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - 按键
extension InstrumentsViewController{
    @objc
    func popPage(){
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source
extension InstrumentsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return nil
        case 1:
            return "禅"
        case 2:
            return "乐器"
        case 3:
            return "动物"
        case 4:
            return "自然"
        case 5:
            return "其他"
        default:
            return "其他"
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 3
        case 1:
            return woodenCount
        case 2:
            return instrumentCount
        case 3:
            return animalCount
        case 4:
            return natureCount
        case 5:
            return otherCount
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 0{
            let cell = InstrumentsCell()
            cell.indexPath = indexPath
            cell.selectionStyle = .none
            var index = indexPath.item
            if indexPath.section == 2{
                index += woodenCount
            }else if indexPath.section == 3{
                index += woodenCount + instrumentCount
            }else if indexPath.section == 4{
                index += woodenCount + instrumentCount + animalCount
            }else if indexPath.section == 5{
                index += woodenCount + instrumentCount + animalCount + natureCount
            }
            cell.woodenFish = woodenFishs[index]
            cell.isShow = styles[index]
            return cell
        }else{
            //第一组
            let cell = UITableViewCell(style: .default, reuseIdentifier: QuickFunctionID)
            var config = cell.defaultContentConfiguration()
            if indexPath.item == quickFunction.count - 1{
                config.attributedText = NSAttributedString(string: quickFunction[indexPath.item],attributes: [.font:FontBody,.foregroundColor:UIColor.white])
            }else{
                config.attributedText = NSAttributedString(string: quickFunction[indexPath.item],attributes: [.font:FontBody,.foregroundColor:UIColor(hexStr: "0x6B87FF")])
            }
            cell.contentConfiguration = config
            cell.backgroundColor = UIColor(hexStr: "0x2C2C2E")
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(white: 1, alpha: 0.5)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //处理第一组
        if indexPath.section == 0{
            var arr = [Bool]()
            switch indexPath.item{
                //隐藏木鱼1 //改变显示内容
            case 0:
                let isShow = !styles[0]
                plistManager.saveStyleIsShow(at: 0, isShow: isShow)
                break
                //隐藏所有音效
            case 1:
                arr = Array(repeating: false, count: styles.count)
                arr[0] = true
                plistManager.saveSettingStylesIsShow(array: arr)
                break
                //显示所有音效
            case 2:
                arr = Array(repeating: true, count: styles.count)
                plistManager.saveSettingStylesIsShow(array: arr)
                break
            default:
                break
            }
            
            tableView.reloadData()
        }
    }

}
