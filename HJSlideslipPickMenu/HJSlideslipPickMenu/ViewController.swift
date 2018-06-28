//
//  ViewController.swift
//  HJSlideslipPickMenu
//
//  Created by haijun on 2018/6/28.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataList:Array<Any>?
    
    lazy var pickMenu:HJSlidelipPickerMenu = {
        let menu = HJSlidelipPickerMenu(frame:.zero)
        menu.delegate = self
        menu.datasource = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "首页"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "菜单", style: .done, target: self, action: #selector(menuClick))
        
        self.view.addSubview(pickMenu)
        pickMenu.frame = CGRect(x: kScreenW, y: 0, width: kScreenW, height: kScreenH)
        
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let jsonStr = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
        
        if let jsonData = jsonStr?.data(using: String.Encoding.utf8.rawValue) { // 解码成功
            
            if let module = try? JSONDecoder().decode(HJSlidelipPickCommonModel.self, from: jsonData) {
                
                print("----------------Complex--------------------")
                print(module.dataList)
                
                dataList = module.dataList
            }
            
        }
        
    }
    
    @objc func menuClick(){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationRepeatAutoreverses(false)
        UIView.setAnimationTransition(.none, for: self.pickMenu, cache: true)
        UIView.setAnimationDuration(0.3)
        self.pickMenu.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:HJSlidelipPickerMenuDataSource,HJSlidelipPickerMenuDelegate{
    
    func menu(menu: HJSlidelipPickerMenu, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return (dataList![section] as! DataList).datas.count
    }
    
    func numberOfSectionsInMenu(menu: HJSlidelipPickerMenu) -> NSInteger {
        return (dataList?.count)!
    }
    
    func menu(menu: HJSlidelipPickerMenu, titleForSection section: NSInteger) -> String {
        return (dataList![section] as! DataList).type
    }
    
    func menu(menu: HJSlidelipPickerMenu, titleForRowAtIndexPath indexPath: IndexPath) -> Any {
        let datas = (dataList![indexPath.section] as! DataList).datas
        return datas[indexPath.row]
    }
    
    func menu(menu: HJSlidelipPickerMenu, didSelectRowAtIndexPath indexPath: IndexPath) {
        let arrayModel = (dataList![indexPath.section] as! DataList).datas
        for model in arrayModel {
            model.isSelect = ""
        }
        let data = arrayModel[indexPath.row]
        data.isSelect = "true"
    }
    
    func menu(menu: HJSlidelipPickerMenu, didDeselectRowAtIndexPath indexPath: IndexPath) {
        let model = (dataList![indexPath.section] as! DataList).datas[indexPath.row]
        model.isSelect = ""
    }
    
    func reloadDataWithMenu(menu: HJSlidelipPickerMenu) {
        //重置
        for datas in dataList! {
            let list = (datas as! DataList).datas
            for model in list {
                model.isSelect = ""
            }
        }
    }
    
    func menu(menu: HJSlidelipPickerMenu, submmitSelectedIndexPaths indexPaths: Array<Any>) {
        //同步数据
    }
    
    
    
}

