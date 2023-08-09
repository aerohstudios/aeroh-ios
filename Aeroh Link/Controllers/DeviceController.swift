//
//  DevicesController.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 07/08/23.
//

import Foundation

class DevicesController: ObservableObject {
    @Published var devices: [DeviceInfo] = []
    
    func fetchDevices(accessToken: String) {
        APIManager.shared.fetchDevices(with: accessToken, errorCallback: { errorMessage in
            print(errorMessage)
        }, completion: { devices in
            DispatchQueue.main.async {
                self.devices.append(contentsOf: devices)
            }
        })
    }
}
