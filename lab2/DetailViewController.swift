//
//  DetailViewController.swift
//  lab2
//
//  Created by Yu Hong Huang on 2017-12-01.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var text:String!


    @IBOutlet weak var textview: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        textview.text = text
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textview.isScrollEnabled = true
        
        let bottom = self.textview.contentSize.height - self.textview.bounds.size.height
        self.textview.setContentOffset(CGPoint(x: 0, y: bottom), animated: true)

    }
    
//    override func viewDidLayoutSubviews() {
//        textview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//    }






}

