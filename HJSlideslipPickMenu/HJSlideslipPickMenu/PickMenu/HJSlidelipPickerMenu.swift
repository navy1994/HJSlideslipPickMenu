//
//  HJSlidelipPickerMenu.swift
//  SwiftDemo
//
//  Created by haijun on 2018/6/26.
//  Copyright © 2018年 wondertex. All rights reserved.
//

import UIKit

@objc protocol HJSlidelipPickerMenuDataSource{
    func menu(menu:HJSlidelipPickerMenu,numberOfRowsInSection section:NSInteger)->NSInteger
    func numberOfSectionsInMenu(menu:HJSlidelipPickerMenu)->NSInteger
    func menu(menu:HJSlidelipPickerMenu,titleForSection section:NSInteger)->String
    @objc optional func menu(menu:HJSlidelipPickerMenu,titleForRowAtIndexPath indexPath:IndexPath)->Any
}

@objc protocol HJSlidelipPickerMenuDelegate{
    @objc optional func menu(menu:HJSlidelipPickerMenu,didSelectRowAtIndexPath indexPath:IndexPath)->Void
    @objc optional func menu(menu:HJSlidelipPickerMenu,didDeselectRowAtIndexPath indexPath:IndexPath)->Void
    @objc optional func reloadDataWithMenu(menu:HJSlidelipPickerMenu)->Void;
    @objc optional func menu(menu:HJSlidelipPickerMenu,didSelectRowsAtIndexPaths indexPaths:Array<Any>)->Void
    @objc optional func menu(menu:HJSlidelipPickerMenu,submmitSelectedIndexPaths indexPaths:Array<Any>)->Void
}

class HJSlidelipPickerMenu: UIView {

    var datasource:HJSlidelipPickerMenuDataSource?
    var delegate:HJSlidelipPickerMenuDelegate?
    
    let collectionCellID = "collectionCellID"
    let headerID = "headerID"
    
    lazy var viewBackground:UIView = {
       let background = UIView()
        background.backgroundColor = kPickerMenuSelectedTextColor
        return background
    }()
    
    lazy var viewBottom:UIView = {
        let bottom = UIView()
        bottom.backgroundColor = UIColor.white
        return bottom
    }()
    
    lazy var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (kScreenW - 38.0 - 13*4)/3, height: 32)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 13, right: 15)
        flowLayout.headerReferenceSize = CGSize(width: kScreenW-38, height: 40)
        let aCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        aCollectionView.dataSource = self as UICollectionViewDataSource
        aCollectionView.delegate = self as UICollectionViewDelegate
        aCollectionView.allowsMultipleSelection = true
        aCollectionView.autoresizesSubviews = false
        aCollectionView.alwaysBounceVertical = false
        aCollectionView.showsVerticalScrollIndicator = false
        aCollectionView.backgroundColor = UIColor.white
        aCollectionView.bounces = false
        aCollectionView.register(HJSlidelipPickCell().classForCoder, forCellWithReuseIdentifier: collectionCellID)
        aCollectionView.register(HJSlidelipPickReusableView().classForCoder, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        return aCollectionView
    }()
    
    lazy var btnReset:UIButton = {
       let bReset = UIButton(type:.custom)
        bReset.backgroundColor = kPickerMenuCellUnselectedColor
        bReset.setTitle("重置", for: .normal)
        bReset.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bReset.setTitleColor(UIColor.darkGray, for: .normal)
        bReset.addTarget(self, action: #selector(resetPicker), for: .touchUpInside)
        return bReset
    }()
    
    lazy var btnSure:UIButton = {
       let bSure = UIButton(type: .custom)
        bSure.backgroundColor = kPickerMenuCellSelectedColor
        bSure.setTitle("确定", for: .normal)
        bSure.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bSure.addTarget(self, action: #selector(surePicker), for: .touchUpInside)
        return bSure
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dismiss))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        
        self.addSubview(viewBackground)
        viewBackground.addSubview(collectionView)
        viewBackground.addSubview(viewBottom)
        viewBottom.addSubview(btnReset)
        viewBottom.addSubview(btnSure)
        
        viewBackground.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(38)
            make.top.right.bottom.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(viewBackground)
            make.top.equalTo(viewBackground).offset(20)
            make.bottom.equalTo(viewBottom.snp.top)
        }
        
        viewBottom.snp.makeConstraints { (make) in
            make.left.right.equalTo(viewBackground)
            make.bottom.equalTo(viewBackground)
            make.height.equalTo(50)
        }
        
        btnReset.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(viewBottom)
            make.width.equalTo(btnSure.snp.width)
            make.right.equalTo(btnSure.snp.left)
        }
        
        btnSure.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(viewBottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func resetPicker() -> Void {
        
        self.delegate?.reloadDataWithMenu!(menu: self)
        let num:Int = (self.datasource?.numberOfSectionsInMenu(menu: self))!
        for i in 0 ..< num{
            let header = self.collectionView.viewWithTag(100+i) as? HJSlidelipPickReusableView
            header?.isShowAll = false
        }
        
        self.collectionView.reloadData()
        self.collectionView.reloadData()
    }
    
    @objc func surePicker() -> Void {
        dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        let point:CGPoint = touch.location(in: self)
        
        if point.x != 0{
            if point.x<38.0{
                dismiss()
            }
        }
    }
    
    @objc func dismiss() -> Void {
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationRepeatAutoreverses(false)
        UIView.setAnimationTransition(.none, for: self, cache: true)
        UIView.setAnimationDuration(0.3)
        self.frame = CGRect(x: kScreenW, y: 0, width: kScreenW, height: kScreenH)
        UIView.commitAnimations()
        synchrodata()
    }
    
    func synchrodata() -> Void {
        self.delegate?.menu!(menu: self, submmitSelectedIndexPaths: self.collectionView.indexPathsForSelectedItems!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension HJSlidelipPickerMenu:UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.datasource?.numberOfSectionsInMenu(menu: self))!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = self.datasource?.menu(menu: self, numberOfRowsInSection: section)
        if (num!>6){
            let header = collectionView.viewWithTag(100+section) as? HJSlidelipPickReusableView
            if header?.isShowAll == false || header?.isShowAll==nil{
                return 6
            }else{
                return num!
            }
        }else{
            return num!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HJSlidelipPickCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! HJSlidelipPickCell
        let datas = self.datasource?.menu!(menu: self, titleForRowAtIndexPath: indexPath) as? Datas
        cell.contentString = datas?.text
        if (datas?.isSelect == "true"){
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        }else{
            cell.isSelected = false
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.menu!(menu: self, didSelectRowAtIndexPath: indexPath)
        UIView.performWithoutAnimation {
            collectionView.reloadSections(NSIndexSet.init(index: indexPath.section) as IndexSet)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.delegate?.menu!(menu: self, didDeselectRowAtIndexPath: indexPath)
        UIView.performWithoutAnimation {
            collectionView.reloadSections(NSIndexSet.init(index: indexPath.section) as IndexSet)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:IndexPath)->CGSize{
//        return CGSize(width: (kScreenW - 38.0 - 13*4)/3, height: 28)
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header:HJSlidelipPickReusableView?
        if kind==UICollectionElementKindSectionHeader {
            if (collectionView.viewWithTag(indexPath.section+100) != nil){
                header = collectionView.viewWithTag(indexPath.section+100) as? HJSlidelipPickReusableView
            }else{
                header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as? HJSlidelipPickReusableView
            }
            weak var weakHeader = header
            header?.tag = indexPath.section+100
            header?.mainTitle.text = self.datasource?.menu(menu: self, titleForSection: indexPath.section)
            
            if header?.isShowAll==nil || header?.isShowAll==false{
                let num = self.datasource?.menu(menu: self, numberOfRowsInSection: indexPath.section)
                if (num!>6){
                    header?.selectedTitle.textColor = kPickerMenuUnselectedTextColor
                    header?.selectedTitle.text = "全部"
                    header?.arrowsIcon.image = UIImage(named: "jiantou_down")
                }else{
                    header?.selectedTitle.text = ""
                    header?.arrowsIcon.image = UIImage(named: "")
                }
            }else{
                if (self.datasource?.menu(menu: self, numberOfRowsInSection: indexPath.section))!>6{
                    header?.arrowsIcon.image = UIImage(named: "jiantou_up")
                }else{
                    header?.arrowsIcon.image = UIImage(named: "")
                }
            }
            
            if (collectionView.indexPathsForSelectedItems != nil){
                for path in collectionView.indexPathsForSelectedItems!{
                    if path.section==indexPath.section{
                        let datas = self.datasource?.menu!(menu: self, titleForRowAtIndexPath: path) as? Datas
                        header?.selectedTitle.text = datas?.text
                        header?.selectedTitle.textColor = UIColor.red
                    }
                }
            }
            
            header?.btnClickBlock = { (clickBtn) in
                if weakHeader?.isShowAll==true{
                    weakHeader?.isShowAll = false
                }else{
                    weakHeader?.isShowAll = true
                }
                UIView.performWithoutAnimation({
                    collectionView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet)
                })
            }
            return header!
        }
        return header!
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer{
            let gesture:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            let translation:CGFloat = gesture.translation(in: self).y
            if translation != 0{
                return false
            }
            if gesture.location(in: self).x > 38.0{
                dismiss()
            }
        }
        return false
    }
    
}
