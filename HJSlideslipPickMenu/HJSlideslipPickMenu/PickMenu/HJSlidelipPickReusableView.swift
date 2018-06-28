//
//  HJSlidelipPickReusableView.swift
//  SwiftDemo
//
//  Created by haijun on 2018/6/26.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import UIKit

class HJSlidelipPickReusableView: UICollectionReusableView {
    
    typealias BtnClickBlock = (_ clickBtn:UIButton)->()
    
    var btnClickBlock:BtnClickBlock!
    
    var isShowAll:Bool?
    
    lazy var btnBackground:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kPickerMenuSelectedTextColor
        btn.addTarget(self, action: #selector(selfClick(_:)), for:.touchUpInside)
        return btn
    }()
    
    lazy var mainTitle:UILabel = {
       let mTitle = UILabel()
        mTitle.textAlignment = .left
        mTitle.textColor = kPickerMenuUnselectedTextColor
        mTitle.font = UIFont.systemFont(ofSize: 13)
        return mTitle
    }()
    
    lazy var selectedTitle:UILabel = {
       let sTitle = UILabel()
        sTitle.textAlignment = .right
        sTitle.textColor = kPickerMenuUnselectedTextColor
        sTitle.font = UIFont.systemFont(ofSize: 13)
        return sTitle
    }()
    
    lazy var arrowsIcon:UIImageView = {
       let aImageView = UIImageView(image: UIImage(named: "jiantou_down"))
        return aImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = UIColor.blue
        
        self.addSubview(btnBackground)
        self.addSubview(mainTitle)
        self.addSubview(selectedTitle)
        self.addSubview(arrowsIcon)
        
        mainTitle.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(50)
        }
        
        selectedTitle.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(mainTitle.snp.right).offset(10)
            make.right.equalTo(arrowsIcon.snp.left).offset(-8)
        }
        
        btnBackground.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.width.equalTo(kScreenW-38)
            make.height.equalTo(40)
        }
        
        arrowsIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kScreenW-38-7-20)
            make.top.equalTo(self).offset(17.5)
            make.width.equalTo(7)
            make.height.equalTo(5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func selfClick(_ button:UIButton) -> Void {
        if let _ = btnClickBlock {
            btnClickBlock(button)
        }
    }
}
