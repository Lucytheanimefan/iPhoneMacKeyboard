//
//  Keyboard.swift
//  CustomKeyboard
//
//  Created by Lucy Zhang on 6/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class Keyboard: NSObject {

    static let sharedInstance = Keyboard()
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: CFNetServiceGetType)
        super.init()
        self.serviceAdvertiser.delegate = self as! MCNearbyServiceAdvertiserDelegate
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    
}

extension Keyboard: MCNearbyServiceAdvertiserDelegate{
    @available(iOS 7.0, *)
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Received invitation from peer")
        //TODO: keyboard stuff
    }

    
    
}
