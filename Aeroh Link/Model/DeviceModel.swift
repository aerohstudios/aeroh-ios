//
//  DeviceModel.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 07/08/23.
//

import Foundation

class DeviceModel: Identifiable, Hashable {
    var id = UUID()
    var name: String

    init(name: String) {
        self.name = name
    }

    static func == (lhs: DeviceModel, rhs: DeviceModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
