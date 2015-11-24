//
//  ViewController.swift
//  DLTagViewDemo
//
//  Created by 刘铎 on 15/11/23.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit
import DLTagView

class ViewController: UIViewController {
    
    var tagView: DLTagView!
    var colorPool: [UIColor]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        colorPool = [
            UIColor(red: 99/255.0, green: 128/255.0, blue: 246/255.0, alpha: 1.0),
            UIColor(red: 113/255.0, green: 154/255.0, blue: 208/255.0, alpha: 1.0),
            UIColor(red: 100/255.0, green: 181/255.0, blue: 213/255.0, alpha: 1.0)
        ];
        
        tagView = DLTagView(frame: CGRect(x: 20, y: 200, width: CGRectGetWidth(view.frame) - 40, height: 190))
        view.addSubview(tagView)
        
        ["Swift", "PHP", "This is a very long string.", "Objective-C", "C#", "C", "C++", "Java", "JavaScript", "Ruby", "Python", "Node.js"].forEach { text in
            var tag = DLTag(text: text)
            let index = Int(arc4random() % 3)
            tag.backgroundColor = colorPool[index]
            tag.borderWidth = 0
            tag.textColor = UIColor.whiteColor()
            tag.cornerRadius = 3.0
            tagView.addTag(tag)
        }
    }

    @IBAction func addButtonTapped(sender: UIButton) {
        tagView.addTag(DLTag(text: "xxx"))
    }
    
    @IBAction func removeButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func removeAllButtonTapped(sender: UIButton) {
        tagView.removeAllTags()
    }
    
}

