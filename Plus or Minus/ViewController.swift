//
//  ViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var lastScrollViewContentOffset: CGFloat = 0.0
    var dayIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        let scrollWidth = scrollView.frame.size.width
        var itemCount: CGFloat = 0
        
        for i in 0...2 {
            itemCount = itemCount + 1
            
            let newX = scrollWidth / 2 + scrollWidth * CGFloat(i)
            
            let circleFrame = CGRect(x: newX - 100, y: (scrollView.frame.size.height / 2) - 100, width: 200, height: 200)
            let circleBtn = DayButton(frame: circleFrame)
            
            circleBtn.setTitle("Yalla", for: .normal)
            
            circleBtn.addTarget(self, action: #selector(dateBtnClicked), for: .touchDown)
            
            scrollView.addSubview(circleBtn)
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: scrollWidth * itemCount, height: scrollView.frame.size.height)
    }
}

