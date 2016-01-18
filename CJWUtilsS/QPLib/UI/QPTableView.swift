//
//  QPTableView.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import MJRefresh
import FlatUIKit

class QPTableView: NSObject {

}



// MARK: - 下拉刷新
public extension UITableView {
    
    public func addRefreshHeader(target:AnyObject!,action:Selector){
        
        let header = CJWRefreshHeader(refreshingTarget: target, refreshingAction: action)
        self.refreshHeader = header
    }
    
    public func addRefreshFooter(target:AnyObject!,action:Selector){
        self.refresFooter = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: action)
    }
    
    public func endRefreshing(){
        endRefreshFooter()
        endRefreshHeader()
    }
    
    public func endRefreshHeader(){
        self.refreshHeader.endRefreshing()
    }
    
    public func endRefreshFooter(){
        self.refresFooter.endRefreshing()
    }
    
    public func showHeader(){
        self.refreshHeader.hidden = false
    }
    public func hideHeader(){
        self.refreshHeader.hidden = true
    }
    public func showFooter(){
        self.refresFooter.hidden = false
    }
    public func hideFooter(){
        self.refresFooter.hidden = true
    }
    
    
}

extension UITableView {
    
    func hideHeaderView(){
        self.tableHeaderView = UIView(frame: CGRectZero)
    }
    
    func hideFooterView(){
        self.tableFooterView = UIView(frame: CGRectZero)
    }
}

// MARK: - 添加脚部,头部label
//extension UITableView {
//    
//    private func createLabel(txt:String) -> UILabel{
//        let label = UILabel(frame: CGRectMake(0, 0, self.frame.width, 44))
//        label.text = txt
//        label.textAlignment = NSTextAlignment.Center
//        label.textColor = UIColor.lightGrayColor()
//        return label
//    }
//    
//    func showHeaderTxt(txt:NSString){
//        self.tableHeaderView = createLabel(txt as String)
//    }
//    
//    func showFooterTxt(txt:NSString){
//        self.tableFooterView = createLabel(txt as String)
//    }
//    
//    func hideHeaderTxt(){
//        hideHeaderView()
//    }
//    
//    func hideFooterTxt(){
//        hideFooterView()
//    }
//}

public extension UITableView {
    public func registerTableViewCell(nibName:String,bundle:NSBundle?,forCellReuseIdentifier:String){
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.registerNib(nib, forCellReuseIdentifier: forCellReuseIdentifier)
        
    }
}

public extension UITableView {
    public var refreshHeader : MJRefreshHeader {
        get {
            return self.mj_header
        }
        
        set {
            self.mj_header = newValue
        }
    }
    
    var refresFooter : MJRefreshFooter {
        get {
            return self.mj_footer
        }
        
        set {
            self.mj_footer = newValue
        }
    }
}

public extension MJRefreshFooter {
    public func showNoData(){
        self.endRefreshingWithNoMoreData()
    }
    
    public func resetNoData(){
        self.resetNoMoreData()
    }
}

private class CJWRefreshHeader : MJRefreshGifHeader {
    
    let idle = "Idle"
    let pulling = "Pulling"
    let loading = "Loading"
    
    let frameCount = 10
    let scale:CGFloat = 60
    let size:CGFloat = 13
    let color = MAIN_COLOR
    
    func setup(){
        
//        let scaleSize = CGSizeMake(scale, scale)
        var idleimgs = Array<UIImage>()
        for index in 1...frameCount {
            
            let img = UIImage(named: "\(idle)\(index)")
            idleimgs.append(img!)
            
        }
        
        var pullingimgs = Array<UIImage>()
        for index in 1...frameCount {
            let img = UIImage(named: "\(pulling)\(index)")
            pullingimgs.append(img!)
        }
        
        var refreshing = Array<UIImage>()
        for index in 1...frameCount {
            let img = UIImage(named: "\(loading)\(index)")
            refreshing.append(img!)
        }
        
        self.setImages(idleimgs, forState: MJRefreshState.Idle)
        self.setImages(pullingimgs, forState: MJRefreshState.Pulling)
        self.setImages(refreshing, forState: MJRefreshState.Refreshing)
        
        self.lastUpdatedTimeLabel!.hidden = true;
        
        let stateLabel = self.stateLabel
        stateLabel?.font = UIFont.systemFontOfSize(size)
        //        stateLabel.textColor = UIColor.bnuMainColor()
        stateLabel?.textColor = color
    }
}