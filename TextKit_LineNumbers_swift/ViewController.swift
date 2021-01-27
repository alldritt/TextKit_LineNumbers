//
//  ViewController.swift
//  TextKit_LineNumbers_swift
//
//  Copyright © 2017 David Phillip Oster. MIT License.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var wrapper: LineNumberTextViewWrapper!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            //  Display some sample text to start with
            let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "rtf")
            let ats = try NSAttributedString(url: fileURL!, options: [:], documentAttributes: nil)
            wrapper.textView?.attributedText = ats
        } catch {}

        //  Respond to software keyboard appearance and dissappearance as per:
        //  http://stackoverflow.com/questions/26213681/ios-8-keyboard-hides-my-textview
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        let viewBounds = view.bounds
        var wrapperFrame = viewBounds
        let topBarOffset = topLayoutGuide.length
        wrapperFrame.origin.y = topBarOffset
        wrapperFrame.size.height -= topBarOffset
        wrapper.frame = wrapperFrame
    }

    @objc func keyboardFrameWillChange(notification: NSNotification) {
        let keyboardEndFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue?)?.cgRectValue
        let keyboardBeginFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue?)?.cgRectValue
        let animationCurve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber?)?.intValue
        let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber?)?.doubleValue

        UIView.animate(withDuration: animationDuration!, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(animationCurve!))], animations: {
            if let oldFrame = self.wrapper?.bounds {
                var newFrame = oldFrame
                let keyboardFrameBegin = self.view.convert(keyboardBeginFrame!, to: nil)
                let keyboardFrameEnd = self.view.convert(keyboardEndFrame!, from: nil)
                if keyboardFrameEnd.origin.y < keyboardFrameBegin.origin.y {
                    newFrame.size.height -= max(0.0, keyboardFrameEnd.size.height)
                }
                self.wrapper.textView?.frame = newFrame
            }
        }, completion: nil)
    }
}
