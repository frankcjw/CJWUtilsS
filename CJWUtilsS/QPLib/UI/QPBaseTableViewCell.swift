//
//  QPBaseTableViewCell.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public class QPBaseTableViewCell: UITableViewCell {
    
    var rootViewController : UIViewController?
    
    var didSetupConstraints = false
    var cellInfo = NSDictionary()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initCell()
        
    }
    
    private func setupAutoLayout(){
        self.contentView.setToAutoLayout()
        contentView.alignLeading("0", trailing: "0", toView: self)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
    }
    
    private func initCell(){
        setupViews(contentView)
        setupAutoLayout()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    public override func updateConstraints() {
        
        //        if !didSetupConstraints {
        //            setupConstrains(contentView)
        //            didSetupConstraints = true
        //        }
        setupConstrains(contentView)
        super.updateConstraints()
    }
    
    func setupConstrains(view:UIView){
    }
    
    func setupViews(view:UIView){
    }
    
    func setInfo(info:NSDictionary){
        self.cellInfo = info
        setupConstrains(contentView)
        
    }
    
    func setup(){
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
}

