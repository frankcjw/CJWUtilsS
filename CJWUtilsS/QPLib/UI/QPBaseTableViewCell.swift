//
//  QPBaseTableViewCell.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

class QPBaseTableViewCell: UITableViewCell {
    
    var rootViewController : UIViewController?
    
    var didSetupConstraints = false
    var cellInfo = NSDictionary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews(contentView)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews(contentView)
        
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            setupConstrains(contentView)
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func setupConstrains(view:UIView){
    }
    
    func setupViews(view:UIView){
    }
    
    func setInfo(info:NSDictionary){
        self.cellInfo = info
    }
    
    func setup(){
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
    
}

