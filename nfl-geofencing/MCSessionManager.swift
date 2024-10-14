import MultipeerConnectivity


class MCSessionManager: NSObject, ObservableObject {
    @Published var connectedPeerID: MCPeerID?
    @Published var receivedData: Data?
    
    var peerDataHandler: ((Data, MCPeerID) -> Void)?
    
    private let mcSession: MCSession
    private let mcAdvertiser: MCNearbyServiceAdvertiser
    private let mcBrowser: MCNearbyServiceBrowser
    
    private let localPeerID = MCPeerID(displayName: UIDevice.current.identifierForVendor!.uuidString)
    private let identityKey = "identity"
    private let identity = "com.takutaku.SwiftApp.kaizen-fitness"
    private let maxNumPeers = 1
    
    override init() {
        let service = "greeting-app"
        self.mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .required)
        self.mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: localPeerID,
            discoveryInfo: [identityKey: identity],
            serviceType: service
        )
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: service)
        
        super.init()
        self.mcSession.delegate = self
        self.mcAdvertiser.delegate = self
        self.mcBrowser.delegate = self
    }
    
    func start() {
        mcAdvertiser.startAdvertisingPeer()
        mcBrowser.startBrowsingForPeers()
    }
    
    func sendDataToAllPeers(data: Data) {
        do {
            try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
            print("Error sending data: \(error)")
        }
    }
    
    func invalidate() {
        suspend()
        mcSession.disconnect()
    }
    
    private func suspend() {
        self.mcAdvertiser.stopAdvertisingPeer()
        self.mcBrowser.stopBrowsingForPeers()
    }
}

extension MCSessionManager: MCSessionDelegate {
    internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            peerConnected(peerID)
        case .notConnected:
            peerDisconnected(peerID: peerID)
        case .connecting:
            break
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }
    
    private func peerConnected(_ peerID: MCPeerID) {
        connectedPeerID = peerID
        if mcSession.connectedPeers.count == maxNumPeers {
            self.suspend()
        }
    }
    
    private func peerDisconnected(peerID: MCPeerID) {
        if peerID == connectedPeerID {
            connectedPeerID = nil
        }
        if mcSession.connectedPeers.count < maxNumPeers {
            self.start()
        }
    }
    
    internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        receivedData = data
    }
    
    internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    internal func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    internal func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {}
}

extension MCSessionManager: MCNearbyServiceBrowserDelegate {
    internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        guard let identityValue = info?[identityKey] else { return }
        if identityValue == identity && mcSession.connectedPeers.count < maxNumPeers {
            browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
        }
    }
    
    internal func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Lost peer: \(peerID.displayName)")
    }
    
    internal func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: any Error) {
        print("Failed to browse: \(error.localizedDescription)")
    }
}

extension MCSessionManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        if self.mcSession.connectedPeers.count < maxNumPeers {
            invitationHandler(true, mcSession)
        }
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: any Error) {
        print("Failed to advertise \(error.localizedDescription)")
    }
}
