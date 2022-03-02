//
//  NetWorkingManager.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 29.07.2021.
//

import Foundation
import SystemConfiguration
class NetworkingManager: ObservableObject {
    @Published var dataList = [Quote]()
    init() {
        if Reachability.isConnectedToNetwork() {
            print("Connected")
            guard let url = URL(string: "https://type.fit/api/quotes") else {return}
            URLSession.shared.dataTask(with: url) {
                (data,_,_) in
                guard let data = data else {return}
                let dataList = try? JSONDecoder().decode([Quote].self, from: data)
                DispatchQueue.main.async {
                    self.dataList = dataList ?? [Quote(text: "No internt connection", author: "Check connction")]
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                self.dataList = [Quote(text: "No internt connection for the quotes", author: "Check connection")]
            }
            print("Not connceted")
        }
        
        }
    
    
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
