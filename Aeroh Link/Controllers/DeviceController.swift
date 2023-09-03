//
//  DevicesController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 07/08/23.
//

import Foundation

class DevicesController: ObservableObject {
    @Published var devices: [DeviceModel] = []
    var isFetchingDevices = false
    
    func fetchDevicesIfNeeded(accessToken: String) {
        guard !isFetchingDevices else {
            return
        }
        isFetchingDevices = true
        APIManager.shared.fetchDevices(with: accessToken) { result in
            switch result {
            case .success(let devices):
                DispatchQueue.main.async {
                    self.devices.append(contentsOf: devices)
                    self.isFetchingDevices = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
