//
//  DLTagButton.swift
//  DLTagView
//
//  Created by 刘铎 on 15/11/23.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit

public class DLTagButton: UIButton {
    
    public var tagInfo: TagInfo!
    
    class func buttonWithTagInfo(tagInfo: TagInfo) -> DLTagButton {
        let button = DLTagButton(type: .Custom)
        button.tagInfo = tagInfo
        button.configure()
        return button
    }
    
    private func configure() {
        if let attributedText = tagInfo.attributedText {
            setAttributedTitle(attributedText, forState: .Normal)
        } else {
            setTitle(tagInfo.text, forState: .Normal)
            setTitleColor(tagInfo.textColor, forState: .Normal)
            titleLabel?.font = UIFont.systemFontOfSize(tagInfo.fontSize)
        }
        
        contentEdgeInsets = tagInfo.padding
        
        setBackgroundImage(imageWithColor(tagInfo.backgroundColor), forState: .Normal)
        
        layer.cornerRadius = tagInfo.cornerRadius
        layer.masksToBounds = true
        
        layer.borderWidth = tagInfo.borderWidth
        layer.borderColor = tagInfo.borderColor.CGColor
        
        enabled = tagInfo.enabled
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
}
