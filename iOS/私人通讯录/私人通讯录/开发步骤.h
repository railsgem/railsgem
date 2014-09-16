1.建立工程
2.删除storyboard上的viewcontroller
3.拖放一个navigation controller在storyboard上
4.删除CYViewController.h 与 CYViewController.m文件
5.整理文件，
    -Classes
        -Controller
6.创建CYLoginViewController继承自 UIViewController,不需要同时创建xib文件
    功能：控制登陆界面
7.创建联系人列表控制器 CYContactsTableViewController 继承自UITableViewController，不需要同时创建xib文件
    功能：联系人列表界面
8.创建添加联系人控制器 CYAddViewController 继承自UIViewController,不需要同时创建xib文件
    功能：添加联系人
9.创建编辑联系人资料控制器 CYEditViewController 继承自UIViewController,不需要同时创建xib文件
    功能：编辑练习人
10.删除storyboard的tableviewController
11.在storyboard上添加一个UIViewController,因为首页CYLoginViewController继承自 UIViewController
    配置UIViewController custom class 为CYLoginViewController,拖线导航（非push方式）
    添加首页标题文字：欢迎使用
    添加其他控件
    *注意：NavigationController连线需要右击选择root View Controller
12.实现CYLoginViewController
    12.1 添加控件outlet
    12.2 删除没用的方法代码：initWithNibName，didReceiveMemoryWarning
    12.3 实现监听文本框的改变：textChange()
    12.4 实现监听“记住密码”与“自动登录” UISwitch控件的逻辑方法
13. 实现注销功能