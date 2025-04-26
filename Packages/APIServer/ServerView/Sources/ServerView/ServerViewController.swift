//
//  ServerViewController.swift
//  APIServerSample
//
//  Created by yuki noda on 2025/04/12.
//

import UIKit
import APIServer

public class ServerViewController: UIViewController {
    
    public static func loadNib() -> ServerViewController {
        return ServerViewController(nibName: nil, bundle: .module)
    }
    
    // MARK: Internal

    public override func viewDidLoad() {
        super.viewDidLoad()
        activityView.isHidden = false
        activityView.startAnimating()
        Task.detached(priority: .background) {
            do {
                let apiServer = try await APIServer()
                try apiServer.routing()
                try await apiServer.start()
                await MainActor.run {
                    self.server = apiServer
                    self.activityView.stopAnimating()
                    self.activityView.isHidden = true
                    self.ipAddressLabel.text = self.getIPAddress() ?? "0.0.0.0"
                }
            }
            catch {
                fatalError("failed load apiserver")
            }
        }
    }

    deinit {
        server.shutdown()
    }
    
    func getIPAddress() -> String? {
        var address = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }
            let interface = ptr?.pointee
            let addrFamily = interface?.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                if let ifaName = interface?.ifa_name,
                   let saLen = interface?.ifa_addr.pointee.sa_len,
                   String(cString: ifaName) == "en0" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    let res = getnameinfo(
                        interface?.ifa_addr,
                        socklen_t(saLen),
                        &hostname,
                        socklen_t(hostname.count),
                        nil,
                        socklen_t(0),
                        NI_NUMERICHOST
                    )
                    if res == 0 {
                        if let str = String(utf8String: hostname) {
                            if str.range(
                                of: "^[\\d.]+$",
                                options: .regularExpression,
                                range: nil,
                                locale: .current
                            ) != nil {
                                address = str
                            }
                        }
                    }
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }

    // MARK: Private

    @IBOutlet private var activityView: UIActivityIndicatorView!
    @IBOutlet private var ipAddressLabel: UILabel!
    
    private var server: APIServer!
}
