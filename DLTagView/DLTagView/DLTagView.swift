//
//  DLTagView.swift
//  DLTagView
//
//  Created by 刘铎 on 15/11/23.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit

@IBDesignable
public class DLTagView: UIScrollView {
    
    // ------------------
    // MARK: - Properties
    // ------------------

    public var padding: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    public var lineSpace = 8 as CGFloat
    public var insets = 8 as CGFloat
    public var preferredMaxLayoutWidth = 20 as CGFloat
    public var singleLine = false
    public var didTapTag: ((TagInfo) -> Void)?
    
    private lazy var tags = [TagInfo]()
    private lazy var tagButtons = [DLTagButton]()
    private var didSetup = false
    
    // --------------
    // MARK: - Layout
    // --------------
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        rearrangeButtons()
    }
    
    // --------------
    // MARK: - Public
    // --------------
    
    public func addTag(tag: TagInfo) {
        let button = createTagButtonWithTag(tag)
        addSubview(button)
        tagButtons.append(button)
        tags.append(tag)
        rearrangeButtons()
    }
    
    public func insertTag(tag: TagInfo, atIndex index: Int) {
        if index + 1 > tags.count {
            addTag(tag)
        } else {
            let button = createTagButtonWithTag(tag)
            insertSubview(button, atIndex: index)
            tagButtons.insert(button, atIndex: index)
            tags.insert(tag, atIndex: index)
            rearrangeButtons()
        }
    }
    
    public func removeTag(tag: TagInfo) {
//        let index = tags.indexOf { (theTag) -> Bool in
//            if theTag === tag {
//                return true
//            } else {
//                return false
//            }
//        }
    }
    
    public func remoteTagAtIndex(index: UInt) {
        
    }
    
    public func removeAllTags() {
        tags.removeAll()
        tagButtons.forEach { tagButton in
            tagButton.removeFromSuperview()
        }
        tagButtons.removeAll()
        rearrangeButtons()
    }
    
    // -------------------------
    // MARK: - Private - Buttons
    // -------------------------
    
    private func createTagButtonWithTag(tag: TagInfo) -> DLTagButton {
        let button = DLTagButton.buttonWithTagInfo(tag)
        button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        return button
    }
    
    @objc private func buttonTapped(button: DLTagButton) {
        didTapTag?(button.tagInfo)
    }
    
    private func rearrangeButtons() {
        var currentX = padding.left
        var currentY = padding.top
        
        var previousView: UIView? = nil
        
        for (index, view) in tagButtons.enumerate() {
            let size = view.intrinsicContentSize()
            if let previousView = previousView {
                currentX += previousView.intrinsicContentSize().width + insets
                
                if currentX + size.width + padding.right > CGRectGetWidth(self.frame) {
                    currentX = padding.left
                    currentY += size.height + lineSpace
                }
                
                view.frame = CGRect(x: currentX, y: currentY, width: size.width, height: size.height)
            } else {
                // 第一个view
                view.frame = CGRect(x: currentX, y: currentY, width: size.width, height: size.height)
            }
            
            previousView = view
            
            if index == subviews.endIndex - 1 {
                self.contentSize = CGSize(width: CGRectGetWidth(self.frame), height: CGRectGetMaxY(view.frame) + padding.bottom)
            }
        }
    }

}
