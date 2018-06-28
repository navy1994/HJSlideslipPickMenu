//
//  Common.swift
//  SwiftDemo
//
//  Created by haijun on 2018/6/27.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//屏幕宽度
let kScreenW = UIScreen.main.bounds.width
//屏幕高度
let kScreenH = UIScreen.main.bounds.height

let kPickerMenuCellUnselectedColor      = kRGBColorFromHex(rgbValue: 0xF8F8F8)
let kPickerMenuCellSelectedColor        = kRGBColorFromHex(rgbValue: 0x3296E1)
let kPickerMenuUnselectedTextColor      = kRGBColorFromHex(rgbValue: 0x0D0D0D)
let kPickerMenuSelectedTextColor        = kRGBColorFromHex(rgbValue: 0xFFFFFF)

// MARK:- 16进制颜色
func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

// MARK:- 自定义打印方法
func LGJLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}
