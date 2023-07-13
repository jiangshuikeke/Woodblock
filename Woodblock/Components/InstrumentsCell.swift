//
//  InstrumentsCell.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/22.
//

import UIKit

class InstrumentsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    init(){
        super.init(style: .default, reuseIdentifier: nil)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 变量
    public var woodenFish:WoodenFishStyle?{
        didSet{
            icon.image = woodenFish?.image
            titleLabel.text = woodenFish?.name
            //第一个木鱼默认显示
            if woodenFish?.id == 0{
                isShowAddButton = false
            }
        }
    }
    
    public var isShow:Bool = false{
        didSet{
            if !isShow{
                addOrDeleteButton.setImage(UIImage(named: "add"), for: .normal)
            }else{
                addOrDeleteButton.setImage(UIImage(named: "remove"), for: .normal)
            }
        }
    }
    
    private lazy var icon:UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 6.0
        imageview.layer.masksToBounds = true
        imageview.backgroundColor = UIColor(hexStr: "0xEBAB59")
        return imageview
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontBody
        return label
    }()
    
    private lazy var addOrDeleteButton:UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 16, height: 16)
        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        return button
    }()
    
    public var isShowAddButton:Bool = true {
        didSet{
            addOrDeleteButton.isHidden = !isShowAddButton
        }
    }
    
    private lazy var plistManager = PlistManager.shared
    
    public var indexPath:IndexPath = IndexPath(row: 0, section: 0)
}

extension InstrumentsCell{
    func initView(){
        isShow = false
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addOrDeleteButton)
        contentView.backgroundColor = UIColor(hexStr: "0x2C2C2E")
        initLayout()
    }
    
    func initLayout(){
        icon.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).offset(13)
            make.height.width.equalTo(26)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(8)
            make.centerY.equalTo(icon)
        }
        
        addOrDeleteButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-16)
            make.centerY.equalTo(icon)
            make.width.height.equalTo(16)
        }
        
    }
}

//MARK: - 按键处理
extension InstrumentsCell{
    @objc
    func toggle(){
        isShow = !isShow
        //更新
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
        plistManager.saveStyleIsShow(at: index, isShow: isShow)
    }
}
