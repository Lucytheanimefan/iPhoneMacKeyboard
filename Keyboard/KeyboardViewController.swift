//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Lucy Zhang on 6/16/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    //@IBOutlet var view: UIView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Perform custom UI setup here
        loadInterface()
    }
    
    func loadInterface() {
        // load the nib file
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        // instantiate the view
        let keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        // add the interface to the main view
        view.addSubview(keyboardView)
        
        // copy the background color
        view.backgroundColor = UIColor.blue
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

}
