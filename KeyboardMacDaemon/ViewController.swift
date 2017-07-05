//
//  ViewController.swift
//  KeyboardMacDaemon
//
//  Created by Jiehan Zheng on 6/26/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import Cocoa
import MultipeerConnectivity

class ViewController: NSViewController {
    
    @IBOutlet var textInputView: NSTextView!
 
    let keyboardServiceMacManager = KeyboardMacManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardServiceMacManager.delegate = self
        keyboardServiceMacManager.send(keyboard: "Sending from the mac manager!")
        
    }
    
    

}

extension ViewController:KeyboardMacManagerDelegate{
    func connectedDevicesChanged(manager: KeyboardMacManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            print("Connected devices: ")
            print(connectedDevices)
        }
    }
    
    func keyboardChanged(manager: KeyboardMacManager, keyboardData: String) {
        OperationQueue.main.addOperation {
            print("keyboardChanged: keyboard data: ")
            print(keyboardData)
        }
    }
}
