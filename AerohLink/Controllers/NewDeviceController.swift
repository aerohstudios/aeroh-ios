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
    let apiManager = APIManager()

    func createDevice(name: String, macAddr: String, completion: @escaping (Bool) -> Void) {
        apiManager.createDevice(name: name, macAddr: macAddr) { result in
            switch result {
            case .success:
                APIManager.shared.fetchDevices(with: KeychainManager.shared.getAccessToken() ?? "") { result in
                    switch result {
                    case .success(let devices):
                        DispatchQueue.main.async { [self] in
                            devicesController.devices.append(contentsOf: devices)
                            devicesController.isFetchingDevices = false
                        }
                    case .failure(let error):
                        print("Error fetching devices: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Error creating device: \(error.localizedDescription)")
            }
        }
    }
}
