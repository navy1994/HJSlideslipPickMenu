## HJSlideslipPickMenu
A pop-up menu

### 演示示例
<div align=center><img width="300"  src="https://github.com/navy1994/HJSlideslipPickMenu/blob/master/gif/demo.gif"/></div>

### Programmatic usage

```
lazy var pickMenu:HJSlidelipPickerMenu = {
    let menu = HJSlidelipPickerMenu(frame:.zero)
          menu.delegate = self
          menu.datasource = self
          return menu
     }()
```

#### HJSlidelipPickerMenuDataSource

```
@objc protocol HJSlidelipPickerMenuDataSource{
    func menu(menu:HJSlidelipPickerMenu,numberOfRowsInSection section:NSInteger)->NSInteger
    func numberOfSectionsInMenu(menu:HJSlidelipPickerMenu)->NSInteger
    func menu(menu:HJSlidelipPickerMenu,titleForSection section:NSInteger)->String
    @objc optional func menu(menu:HJSlidelipPickerMenu,titleForRowAtIndexPath indexPath:IndexPath)->Any
}
```

#### HJSlidelipPickerMenuDelegate

```
@objc protocol HJSlidelipPickerMenuDelegate{
    @objc optional func menu(menu:HJSlidelipPickerMenu,didSelectRowAtIndexPath indexPath:IndexPath)->Void
    @objc optional func menu(menu:HJSlidelipPickerMenu,didDeselectRowAtIndexPath indexPath:IndexPath)->Void
    @objc optional func reloadDataWithMenu(menu:HJSlidelipPickerMenu)->Void;
    @objc optional func menu(menu:HJSlidelipPickerMenu,didSelectRowsAtIndexPaths indexPaths:Array<Any>)->Void
    @objc optional func menu(menu:HJSlidelipPickerMenu,submmitSelectedIndexPaths indexPaths:Array<Any>)->Void
}
```

### Thanks

[HJSlideslipPickMenu](https://github.com/navy1994/HJSlideslipPickMenu.git) by navy1994.
