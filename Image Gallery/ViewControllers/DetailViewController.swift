//
//  DetailViewController.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 9/5/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {

    var photo:Photo?
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var detailWebview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(photo?.link)
        detailWebview.loadRequest(NSURLRequest(URL: NSURL(string: (self.photo?.link)!)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func shareAction(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setSubject("Check this out!!!")
        let body = "<a href=\"\((self.photo?.link)! as String)\">Click Me!</a>\n"
        mailComposerVC.setMessageBody(body, isHTML: true)
        
        return mailComposerVC
    }
    func showSendMailErrorAlert() {
        
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    @IBAction func doneAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }

}

extension DetailViewController: UIWebViewDelegate {

    func webViewDidStartLoad(webView: UIWebView) {
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.activityIndicator.stopAnimating()
    }
    
}

extension DetailViewController: MFMailComposeViewControllerDelegate{
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {

        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)

    }

}
