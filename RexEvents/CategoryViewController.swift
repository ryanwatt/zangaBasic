//
//  CategoryViewController.swift
//  RexEvents
//
//  Created by Paul O'Neill on 3/1/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    


    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    @IBAction func school(sender: AnyObject) {
        UIView.animateWithDuration(1.0) { () -> Void in
            self.loadingView.alpha = 0.9
            self.loadingIndicator.startAnimating()
            self.loadingLabel.text = "Fetching school events..."
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        loadingLabel.text = ""
    }
    
    
    @IBAction func parties(sender: AnyObject) {
    }
    
    @IBAction func movies(sender: AnyObject) {
    }
    
    @IBAction func food(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    

}
