//
//  APSwipeTableViewCell.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

public enum AP_SwipeCellType {
    case none
    case both
    case right
    case left
}

public enum AP_SwipeCellState {
    case normal
    case swipe_left
    case swipe_right
}

class APSwipeTableViewCell: UITableViewCell {
    
    var AP_type : AP_SwipeCellType = .right
    
    var AP_gestureState : AP_SwipeCellState = .normal
    
    open var AP_shouldExceedThreshold: Bool = true
    
    var AP_swipeWidth : CGFloat = 70
    
    
    var AP_currentOffset : CGFloat = 0
    
    // Control how much elastic resistance there is past threshold, if it can be exceeded. Default is `0.7` and `1.0` would mean no elastic resistance
    open var AP_panElasticityFactor: CGFloat = 0.75
    // MARK: - Swipe Cell Functions
    lazy var swipeContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
//        view.frame = self.bounds
        return view
    }()
    
    open func initialize() {
        
        contentView.addSubview(swipeContentView)
        swipeContentView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.snp.width).offset(0)
            make.left.top.bottom.equalTo(0)
        }
        
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.black
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(APSwipeTableViewCell.handlePanGesture(_:)))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
        
        let backgroundView: UIView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.black
        self.backgroundView = backgroundView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.swipeContentView.height = self.height
        self.swipeContentView.width = self.width
    }
    
    @objc open func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation : CGPoint = panGestureRecognizer.translation(in: panGestureRecognizer.view)
        var panOffset: CGFloat = translation.x

        var swipeWidth : CGFloat = 0
        if panOffset >= 0
        {
            swipeWidth = AP_swipeWidth
            AP_gestureState = .swipe_right
        }
        else
        {
            swipeWidth = AP_swipeWidth
            AP_gestureState = .swipe_left
        }

        let point_x : CGFloat = translation.x + AP_currentOffset

        
        if self.AP_shouldExceedThreshold {
            let offset: CGFloat = abs(point_x)
            panOffset = abs(offset - ((offset - swipeWidth ) * self.AP_panElasticityFactor))
            panOffset *= translation.x < 0 ? -1.0 : 1.0
        } else {
            
            panOffset = translation.x < 0 ? -swipeWidth : swipeWidth
        }
        switch panGestureRecognizer.state {
        case .began:
            
            UIView.animate(withDuration: 0.2, animations: {
                self.swipeContentView.x = self.AP_currentOffset
            })
            break
        case .changed:
            if (AP_type == .right) && (AP_gestureState == .swipe_left)
            {
                UIView.animate(withDuration: 0.2, animations: {
                    self.swipeContentView.snp.updateConstraints({ (make) in
                        make.left.equalTo(panOffset)
                    })
                    self.contentView.layoutIfNeeded()
                })
            }
            else if (AP_type == .right) && (AP_gestureState == .swipe_right)
            {
                UIView.animate(withDuration: 0.2, animations: {
                    self.swipeContentView.snp.updateConstraints({ (make) in
                        make.left.equalTo(min(0,panOffset + self.AP_currentOffset))
                    })
                    self.contentView.layoutIfNeeded()
                })

            }
            break
        case .ended:
            
            let offset_abs : CGFloat = abs(panOffset)
            
            if (AP_type == .right) && (AP_gestureState == .swipe_left)
            {
                if offset_abs >= (swipeWidth/2.0)
                {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.swipeContentView.snp.updateConstraints({ (make) in
                            if panOffset >= 0
                            {
                                make.left.equalTo(self.AP_swipeWidth)
                            }
                            else{
                                make.left.equalTo(-self.AP_swipeWidth)
                            }
                        })
                        self.contentView.layoutIfNeeded()
                    })
                    if AP_gestureState == .swipe_left
                    {
                        AP_currentOffset = -AP_swipeWidth
                    }
                    else if AP_gestureState == .swipe_right
                    {
                        AP_currentOffset = AP_swipeWidth
                    }
                }
            }
            else
            {
                resetFrame()
            }
         
            break
        case .cancelled:
            
            break
        case .possible:
            
            break
        default:
            break
        }
    }
    
    func resetFrame()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeContentView.snp.updateConstraints({ (make) in
                make.left.equalTo(0)
            })
            self.contentView.layoutIfNeeded()
        })
        AP_currentOffset = 0
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && (AP_type != .none){
            let pan:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            let translation: CGPoint = pan.translation(in: self.superview)
            return (fabs(translation.x) / fabs(translation.y) > 1) ? true : false
        }
        return false

    }

}
