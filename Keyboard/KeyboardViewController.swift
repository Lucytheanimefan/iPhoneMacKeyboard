//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Lucy Zhang on 6/25/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, KeyboardManagerDelegate {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    let keyboardServiceManager = KeyboardManager()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardServiceManager.delegate = self
        createNextButton()
        createTestButton()
        
    }
    
    func createNextButton(){
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Anime is cool", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    func createTestButton(){
        var testButton:UIButton = UIButton(type: .custom)
        testButton.addTarget(self, action: #selector(sendKeyboardData), for: .touchUpInside)
        testButton.tag = 1
        self.view.addSubview(testButton)
    }
    
    func sendKeyboardData(sender: UIButton!){
        //test
        keyboardServiceManager.send(keyboard: "TEST DATA ANIME IS COOL")
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
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    // MARK : KeyboardManagerDelegate
    func connectedDevicesChanged(manager : KeyboardManager, connectedDevices: [String]){
        OperationQueue.main.addOperation {
            print("Connected devices: ")
            print(connectedDevices)
        }
    }
    func keyboardChanged(manager : KeyboardManager, keyboardData:String){
        OperationQueue.main.addOperation {
            print("keyboardChanged: keyboard data: ")
            print(keyboardData)
        }
    }

}
