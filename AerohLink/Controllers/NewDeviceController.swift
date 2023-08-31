//
//  NewDeviceController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 25/08/23.
//

import SwiftUI
import Alamofire

class NewDeviceController: ObservableObject {
    @Published var device: Device?
    @StateObject private var devicesController = DevicesController()

    func createDevice(name: String, macAddr: String, completion: @escaping (Bool) -> Void) {
        APIManager.createDevice(name: name, macAddr: macAddr) {
            APIManager.shared.fetchDevices(with: KeychainManager.shared.getAccessToken() ?? "", errorCallback: { errorMessage in
            }, completion: { devices in
                DispatchQueue.main.async { [self] in
                    devicesController.devices.append(contentsOf: devices)
                    devicesController.isFetchingDevices = false
                }
            })
        }
    }
}
