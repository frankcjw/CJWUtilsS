//
//  QPBaseTableViewCell.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public class QPBaseTableViewCell: UITableViewCell {
    
    public var rootViewController : UIViewController?
    
    var didSetupConstraints = false
    public var cellInfo = NSDictionary()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews(contentView)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews(contentView)
        
    }
    
    override public func updateConstraints() {
        if !didSetupConstraints {
            setupConstrains(contentView)
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    public func setupConstrains(view:UIView){
    }
    
    public func setupViews(view:UIView){
    }
    
    public func setInfo(info:NSDictionary){
        self.cellInfo = info
    }
    
    public func setup(){
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
    
}

