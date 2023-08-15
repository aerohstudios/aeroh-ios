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
        APIManager.shared.fetchDevices(with: accessToken, errorCallback: { errorMessage in
            print(errorMessage)
        }, completion: { devices in
            DispatchQueue.main.async {
                self.devices.append(contentsOf: devices)
                self.isFetchingDevices = false
            }
        })
    }
}
