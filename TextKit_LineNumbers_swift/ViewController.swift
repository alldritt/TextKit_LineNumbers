//
//  ViewController.swift
//  TextKit_LineNumbers_swift
//
//  Created by david on 9/30/17.
//  Copyright © 2017 David Phillip Oster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var wrapper: LineNumberTextViewWrapper!

  override func viewDidLoad() {
    super.viewDidLoad()


   
    do {
      //  Display some sample text to start with
      let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "rtf")
      let ats  =  try NSAttributedString.init(url: fileURL!, options: [:], documentAttributes: nil)
      self.wrapper.textView?.attributedText = ats;
    } catch {
    }

    //  Respond to software keyboard appearance and dissappearance as per:
    //  http://stackoverflow.com/questions/26213681/ios-8-keyboard-hides-my-textview
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameDidChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidLayoutSubviews() {
    let viewBounds = self.view.bounds
    var wrapperFrame = viewBounds
    let topBarOffset = self.topLayoutGuide.length
    wrapperFrame.origin.y = topBarOffset
    wrapperFrame.size.height -= topBarOffset
    wrapper.frame = wrapperFrame
  }
  
  func keyboardFrameDidChange(notification: NSNotification) {
    let keyboardEndFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue?)?.cgRectValue
    let keyboardBeginFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.cgRectValue
    let animationCurve = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber?)?.intValue
    let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber?)?.doubleValue

    UIView.animate(withDuration: animationDuration!, delay: 0, options: [UIViewAnimationOptions(rawValue: UInt(animationCurve!))], animations: {
      var newFrame = self.view.frame
      let keyboardFrameEnd = self.view.convert(keyboardEndFrame!, from: nil)
      let keyboardFrameBegin = self.view.convert(keyboardBeginFrame!, to: nil)
      newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
      self.view.frame = newFrame;
    }, completion: nil)
    
    
  }

}

