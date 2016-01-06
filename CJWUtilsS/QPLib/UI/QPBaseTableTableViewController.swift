//
//  QPBaseTableTableViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import FlatUIKit
import DZNEmptyDataSet

//private let imageError = UIImage(color: COLOR_CLEAR)//UIImage(named: "Cry")
//private let imageLoading = UIImage(color: COLOR_CLEAR)//UIImage(named: "Loading")

private let imageError = UIImage(named: "Cry")//UIImage(named: "Cry")
private let imageLoading = UIImage(named: "Loading")

let TIPS_LOADING = ""//"加载中..."
let TIPS_LOAD_FAIL = ""//"加载失败"
let TIPS_TAP_RELOAD = ""//"点击重新加载"
let TIPS_NETWORK_EXCEPTION = "网络不是很给力,加载就失败了.."
let TIPS_CLEANING_CACHE = "正在清除缓存,请稍候"

enum ImageType {
    case Loading
    case Error
}

extension UIViewController {
    func fixNavigationBarColor(animated: Bool){
        assertionFailure("lib not been imported")
//        self.navigationController?.navigationBar.translucentWith(COLOR_WHITE)
//        self.navigationController?.navigationBar.translucent = false
//        
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
    }
}

class QPBaseTableViewController: UITableViewController,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    
    var controllerInfo = NSDictionary()
    
    var page = 1
    private var shouldShowEmptyStatus:Bool = true
    private var statusText = TIPS_LOADING
    private var statusDesciption = TIPS_TAP_RELOAD
    private var statusImage = imageLoading
    
    var shouldHideNavigationBar : Bool = false
    
    override func viewWillAppear(animated: Bool) {
        
        
        //        IQKeyboardManager.sharedManager().enable = false
        //        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        if shouldHideNavigationBar {
            
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }else{
            
            fixNavigationBarColor(animated)
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //        if shouldHideNavigationBar {
        //            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        //            self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        //
        //        }
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
    }
    
    func tableViewLoading(){
        setTableViewEmptyStatus(TIPS_TAP_RELOAD, description: nil,imageType: ImageType.Loading)
    }
    
    func setTableViewEmptyStatus(tableView:UITableView,title:String,description:String?,imageType:ImageType?){
    }
    
    func setTableViewEmptyStatus(title:String,description:String?,imageType:ImageType?){
        if description == nil {
            statusDesciption = ""
        }else{
            statusDesciption = description!
        }
        
        if imageType != nil {
            switch imageType! {
            case .Error:
                statusImage = imageError
            case .Loading:
                statusImage = imageLoading
            default:
                statusImage = imageLoading
            }
        }
        
        statusText = title
        self.tableView.reloadEmptyDataSet()
    }
    
    func hideTableViewEmptyStatus(){
        shouldShowEmptyStatus = false
        self.tableView.reloadEmptyDataSet()
    }
    
    func showTableViewEmptyStatus(){
        shouldShowEmptyStatus = true
        self.tableView.reloadEmptyDataSet()
    }
    
    
    
    func tableViewLoadFail(){
        statusImage = imageError
        setTableViewEmptyStatus(TIPS_LOAD_FAIL, description: TIPS_TAP_RELOAD,imageType: ImageType.Error)
    }
    
    func tableViewNetworkException(){
        setTableViewEmptyStatus(TIPS_NETWORK_EXCEPTION, description: TIPS_TAP_RELOAD,imageType: ImageType.Error)
    }
    
    func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
        return CGPointMake(0, -30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tableView.emptyDataSetSource = self;
        //        self.tableView.emptyDataSetDelegate = self;
//        self.tableView.clearExtraLines()
        self.setBackTitle("")
        request()
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let att = [NSFontAttributeName:UIFont.systemFontOfSize(17),NSForegroundColorAttributeName:UIColor.lightGrayColor()]
        return NSAttributedString(string: statusText, attributes: att)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let att = [NSFontAttributeName:UIFont.systemFontOfSize(13),NSForegroundColorAttributeName:UIColor.lightGrayColor()]
        return NSAttributedString(string: statusDesciption, attributes: att)
    }
    
    func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
        return shouldShowEmptyStatus
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return statusImage!
    }
    
    func emptyDataSetDidTapView(scrollView: UIScrollView!) {
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func reloadData(){
        self.tableView.reloadData()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}



extension UITableViewController {
    func registerTableViewCell(nibName:String,bundle:NSBundle?,forCellReuseIdentifier:String){
        self.tableView.registerTableViewCell(nibName, bundle: bundle, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func registerTableViewCell(nibName:String,bundle:NSBundle?){
        self.tableView.registerTableViewCell(nibName, bundle: bundle, forCellReuseIdentifier: nibName)
    }
    
    func registerTableViewCell(nibName:String){
        self.tableView.registerTableViewCell(nibName, bundle: nil, forCellReuseIdentifier: nibName)
    }
}