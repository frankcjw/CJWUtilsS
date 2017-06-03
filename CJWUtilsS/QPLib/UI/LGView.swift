//
//  LGView.swift
//  CJWUtilsS
//
//  Created by Frank on 21/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit
import MZTimerLabel

class LGView: UIView {

}

public class LGColumnsCell: QPTableViewCell {

	public var columnView: QPColumnsView!

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		let count = numberOfColumn()
		columnView = QPColumnsView(count: count)
		view.addSubview(columnView)
		columnView.custom { (label, index) in
			label.textColor = UIColor.darkGrayColor()
		}
		columnView.hideLines()
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		columnView.equalConstrain()
		columnView.heightConstrain("\(heightPredicate())")
	}

	public func heightPredicate() -> String {
		return ">=44"
	}

	public func numberOfColumn() -> Int {
		return 1
	}
}

public class LGColumnsCell2: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 2
	}
}

public class LGColumnsCell3: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 3
	}
}

public class LGColumnsCell4: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 4
	}
}

public class LGColumnsCell5: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 5
	}
}

public class LGColumnsCell6: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 6
	}
}

/// 标题 大标题
public class LGColumnsTitleCell: QPTableViewCell {

	public var columnView: QPColumnsView!

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		let count = numberOfColumn()
		columnView = QPColumnsView(count: count)
		view.addSubview(columnView)
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		columnView.equalConstrain()
		columnView.heightConstrain(">=150")
	}

	public func numberOfColumn() -> Int {
		return 1
	}

	public override func drawRect(rect: CGRect) {
		super.drawRect(rect)
	}

	public func setTitle(title: String, subtitle: String, label: UILabel) {
		label.text = "\(title)\n\n\(subtitle)"
		let range = NSMakeRange(0, title.length())
		label.setTextFont(UIFont.systemFontOfSize(40), atRange: range)
		label.textColor = UIColor.whiteColor()
		label.setTextColor(UIColor.mainColor(), atRange: range)
	}
}

public class LGColumnsTitleCell2: LGColumnsTitleCell {
	public override func numberOfColumn() -> Int {
		return 2
	}
}

public class LGColumnsTitleCell3: LGColumnsTitleCell {
	public override func numberOfColumn() -> Int {
		return 3
	}
}


public class LGTimerLabel: UILabel {
    
    public typealias LGTimerLabelBlock = () -> ()
    public typealias LGTimerLabelCanBlock = () -> Bool
    
    var block: LGTimerLabelBlock?
    
    var startBlock: LGTimerLabelBlock?
    
    var canStartBlock: LGTimerLabelCanBlock?
    
    public func onTimesUp(block: LGTimerLabelBlock) {
        self.block = block
    }
    
    public func canStart(block: LGTimerLabelCanBlock) {
        self.canStartBlock = block
    }
    
    public func onStart(block: LGTimerLabelBlock) {
        self.startBlock = block
    }
    
    var actoun: Selector?
    var target: AnyObject?
    
    public override func addTapGesture(target: AnyObject?, action: Selector) {
        self.onStart {
            target?.performSelector(action, withObject: nil)
            //			self.performSelector(action, withObject: target)
            //            action.
        }
    }
    
    func startCounting(startDate: NSDate) {
        
        userInteractionEnabled = false
        
        self.timer = MZTimerLabel(label: self, andTimerType: MZTimerLabelTypeTimer)
        self.timer.timeFormat = "重新获取(ss)"
        let date = startDate.dateByAddingTimeInterval(60)
        self.timer.setCountDownToDate(date)
        self.timer.startWithEndingBlock { (time) in
            self.text = "点击获取"
            self.userInteractionEnabled = true
            self.block?()
            LGTimerUtils.sharedInstance.startDate = nil
        }
    }
    
    func setupTimer() {
        let date = NSDate()
        if let startDate = LGTimerUtils.sharedInstance.startDate {
            let min = startDate.minutesBeforeDate(date)
            log.debug("min \(min) \(date) \(startDate)")
            if min <= 1 {
                let date = NSDate()
                startCounting(startDate)
            } else {
            }
        } else {
            //			startCounting()
        }
    }
    
    var timer: MZTimerLabel!
    
    func onTap() {
        //        if let block = canStartBlock {
        //
        //        }else{
        //        }
        var flag = true
        if let block = canStartBlock {
            flag = block()
        }
        
        if flag {
            let startDate = NSDate()
            LGTimerUtils.sharedInstance.startDate = startDate
            startCounting(startDate)
            startBlock?()
        }
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        setup(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(self)
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        cornorRadius(5)
        
    }
    
    func setup(view: UIView) {
        //		self.userInteractionEnabled = true
        //		let tap = UITapGestureRecognizer(target: self, action: #selector(LGTimerLabel.onTap))
        //		self.addGestureRecognizer(tap)
        super.addTapGesture(self, action: #selector(LGTimerLabel.onTap))
        //        super.addTapGesture(self, action: <#T##Selector#>)
        setupTimer()
        self.backgroundColor = UIColor.mainColor()
        self.textColor = UIColor.whiteColor()
        self.fontNormal()
        textAlignmentCenter()
        self.text = "获取验证码"
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
}

public class LGTimerUtils: NSObject {
    var startDate: NSDate?
    
    public class var sharedInstance: LGTimerUtils {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: LGTimerUtils? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = LGTimerUtils()
        }
        return Static.instance!
    }
    
}
