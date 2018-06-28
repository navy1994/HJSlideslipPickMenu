//
//  HJSlidelipPickCommonModel.swift
//  SwiftDemo
//
//  Created by haijun on 2018/6/26.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import UIKit

class HJSlidelipPickCommonModel : Codable{
    
    let dataList:[DataList]
    
    init(dataList: [DataList]) {
        
        self.dataList = dataList
    }
}

class Datas : Codable {
    let text:String
    var isSelect:String?
    
    init(text: String, isSelect: String) {
        
        self.text = text
        self.isSelect = isSelect
    }
}

class DataList : Codable {
    let type:String
    let datas:[Datas]
    init(type: String, datas: [Datas]) {
        
        self.type = type
        self.datas = datas
    }
}

//class HJSlidelipPickCommonModel: NSObject {
//    let decoder = JSONDecoder()
//    let module = try decoder.decode
//}
