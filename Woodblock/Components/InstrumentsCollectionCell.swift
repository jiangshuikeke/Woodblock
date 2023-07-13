//
//  InstrumentsCollectionCell.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/23.
//

import UIKit

/*
 设置界面的乐器
 */
class InstrumentsCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 变量
    private lazy var imageView:UIImageView = UIImageView()
    
    public var image:UIImage?{
        didSet{
            imageView.image = image
        }
    }
    
    private lazy var backView:UIImageView = UIImageView(image: UIImage(named: "selected"))
    
    override var isSelected: Bool{
        didSet{
            backView.isHidden = !isSelected
        }
    }
    
}

//MARK: - UI
extension InstrumentsCollectionCell{
    func initView(){
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(backView)
        backView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        
        initLayout()
    }
    
    func initLayout(){
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        backView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
