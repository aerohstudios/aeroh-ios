//
//  NewDeviceController.swift
//  AerohLink
//
//  Created by Tanishq Patidar on 08/09/23.
//

import SwiftUI
import Alamofire

class NewDeviceController: ObservableObject {
    @StateObject private var devicesController = DevicesController()
    let apiManager = APIManager()
    @Published var error: Error?
    @Published var showErrorAlert = false
    @Published var apiCallSuccess = false
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
                            self.apiCallSuccess = true
                        }
                    case .failure(let error):
                        print("Error fetching devices: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.apiCallSuccess = false
                    self.showErrorAlert = true
                    self.error = error
                }
            }
        }
    }
}
