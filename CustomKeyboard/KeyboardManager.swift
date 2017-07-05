//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by Lucy Zhang on 6/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import Foundation
//import UIKit
import MultipeerConnectivity

protocol KeyboardManagerDelegate {
    
    func connectedDevicesChanged(manager : KeyboardManager, connectedDevices: [String])
    func keyboardChanged(manager : KeyboardManager, keyboardData:String)
    
}


class KeyboardManager: NSObject {

    static let sharedInstance = KeyboardManager()
    private let serviceType = "keyboard"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    var delegate: KeyboardManagerDelegate?
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    //to scan for the advertised service on other devices
    private let serviceBrowser : MCNearbyServiceBrowser
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: self.serviceType )
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: self.serviceType)
        super.init()
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
         self.serviceBrowser.stopBrowsingForPeers()
    }
    
    func send(keyboard: String){ //TODO: create a data model for keyboard data
         NSLog("%@", "send keyboard: \(keyboard) to \(session.connectedPeers.count) peers")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(keyboard.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
    }
    
}

//TODO: keyboard stuff
extension KeyboardManager: MCNearbyServiceAdvertiserDelegate{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
}

extension KeyboardManager: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension KeyboardManager: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.keyboardChanged(manager: self, keyboardData: str)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
