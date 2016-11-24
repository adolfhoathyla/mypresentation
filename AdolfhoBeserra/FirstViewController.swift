//
//  FirstViewController.swift
//  AdolfhoBeserra
//
//  Created by Adolfho Athyla on 16/04/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var hello: UILabel!
    @IBOutlet var im: UILabel!
    @IBOutlet var me: UILabel!
    @IBOutlet var buttonKnowMe: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.hello.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 2.0, options: .CurveEaseOut, animations: { () -> Void in
            self.im.alpha = 1
            self.me.alpha = 1
        }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 4.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.buttonKnowMe.alpha = 1
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonKnowMe.alpha = 0
        self.hello.alpha = 0
        self.im.alpha = 0
        self.me.alpha = 0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToMap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
