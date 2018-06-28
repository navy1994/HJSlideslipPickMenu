//
//  HJSlidelipPickCell.swift
//  SwiftDemo
//
//  Created by haijun on 2018/6/26.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import UIKit

class HJSlidelipPickCell: UICollectionViewCell {
    var contentString:String?{
        willSet{
            
        }
        didSet{
            label.text = contentString
        }
    }
    
    lazy var label:UILabel = {
       let aLabel = UILabel()
        aLabel.layer.masksToBounds = true
        aLabel.layer.cornerRadius = 3
        aLabel.textAlignment = .center
        aLabel.backgroundColor = kRGBColorFromHex(rgbValue: 0xF8F8F8)
        aLabel.font = UIFont.systemFont(ofSize: 13)
        return aLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
    
    override var isSelected: Bool{
        willSet{
            if newValue {
                label.backgroundColor = kRGBColorFromHex(rgbValue: 0x3296E1)
                label.textColor = kRGBColorFromHex(rgbValue: 0xFFFFFF)
            }else{
                label.backgroundColor = kRGBColorFromHex(rgbValue: 0xF8F8F8)
                label.textColor = kRGBColorFromHex(rgbValue: 0x0D0D0D)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
