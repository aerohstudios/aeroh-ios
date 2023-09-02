//
//  SearchBluetoothDevices.swift
//  Aeroh Link
//
//  Created by Tanishq Patidar on 10/08/23.
//

import SwiftUI
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @Published var isBluetoothOn: Bool = false
    @Published var discoveredPeripherals: [CBPeripheral] = []
    
    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothOn = true
        } else {
            isBluetoothOn = false
        }
    }
    
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func connectPeripheral(peripheral: CBPeripheral) {
        centralManager.stopScan()
        connectedPeripheral = peripheral
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if let deviceName = peripheral.name?.lowercased(), deviceName.hasPrefix("aeroh") {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
    }
}

struct SearchBluetoothDevices: View {
    @StateObject var bluetoothManager = BluetoothManager()
    @State private var showBluetoothModal = false
    @AppStorage("isToggleOn") private var isToggleOn = false
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.06, green: 0.05, blue: 0.08)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    if bluetoothManager.isBluetoothOn {
                        HStack(spacing: 5) {
                            ProgressView()
                                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                            
                            Text("Searching for nearby devices")
                                .font(Font.custom("Poppins", size: 16))
                                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                            
                        }
                        
                    ScrollView {
                        VStack(alignment: .center) {
                            
                            ForEach(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
                                BluetoothDeviceRowView(device: DeviceModel(name: peripheral.name ?? "Unknown"), isLastDevice: false)
                                    .onTapGesture {
                                        bluetoothManager.connectPeripheral(peripheral: peripheral)
                                    }
                            }
                        }
                        .padding(.vertical)
                        .onAppear {
                            bluetoothManager.startScanning()
                        }
                    }
                        
                        Spacer()
                        
                    } else {
                        if isToggleOn {
                            HStack(spacing: 5) {
                                ProgressView()
                                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                                
                                Text("Searching for nearby devices")
                                    .font(Font.custom("Poppins", size: 16))
                                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                            }
                            VStack(alignment: .center) {
                                BluetoothDeviceRowView(device: DeviceModel(name: "Aeroh Link"), isLastDevice: true)
                                
                                
                            }
                            .padding(.vertical)
                            
                            
                        }
                        else {
                            Button(action: {
                                showBluetoothModal.toggle()
                            }, label: {
                                HStack {
                                    Text("Turn on Bluetooth")
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                    Image("BluetoothOffIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity, minHeight: 55)
                                .background(Color(red: 0.16, green: 0.16, blue: 0.16))
                                .clipShape(Capsule())
                            })
                        }
                        
                        Spacer()
                    }
                }.padding()
                    .sheet(isPresented: $showBluetoothModal) {
                        BottomSheetView()
                            .presentationDetents([.medium])
                            .presentationBackground(.black)
                            .presentationCornerRadius(25)
                    }
            }
        }
        .navigationTitle("Add Device")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BluetoothDeviceRowView: View {
    var device: DeviceModel
    var isLastDevice: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 60){
            Image("AerohLinkIllustration")
                .resizable()
                .frame(width: 113.0, height: 68.34)
                .aspectRatio(1, contentMode: .fit)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(device.name)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                
                NavigationLink(destination: DeviceNamingScreen(), label: {
                    Text("Add")
                        .font(.system(size: 12))
                        .frame(width: 79, height: 30)
                        .foregroundColor(Color(red: 0.06, green: 0.05, blue: 0.08))
                        .background(Color(red: 1.00, green: 0.79, blue: 0.23))
                        .clipShape(Capsule())
                })
            }.padding(.horizontal)
            
        }.foregroundColor(.clear)
            .frame(width: 351, height: 124)
            .background(Color(red: 0.16, green: 0.16, blue: 0.16))
            .cornerRadius(15)
    }
}

struct BottomSheetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            HStack{
                Image("BluetoothOnIcon")
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Aeroh link needs bluetooth to connect")
                        .font(
                            Font.system(size: 16)
                                .weight(.semibold)
                        )
                        .foregroundColor(.white)
                    
                    Text("Enable Bluetooth to add aeroh link")
                        .font(Font.system(size: 14))
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                }
            }
            
            Divider()
                .frame(height: 2)
                .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
            
            HStack(){
                VStack(alignment: .leading, spacing: 5){
                    Text("Go to settings and turn on bluetooth")
                        .font(Font.system(size: 16))
                        .foregroundColor(.white)
                    
                    Text("Go to settings >")
                        .font(Font.system(size: 14))
                        .foregroundColor(Color(red: 1, green: 0.78, blue: 0.23))
                }
                Image("SettingsIllustration")
            }
            Divider()
                .frame(height: 2)
                .overlay(Color(red: 0.16, green: 0.16, blue: 0.16))
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text("Turn on Bluetooth")
                        .font(Font.custom("Inter", size: 16))
                        .foregroundColor(.white)
                        .frame(width: 206, alignment: .topLeading)
                    
                    
                    Text("Turned on")
                        .font(Font.custom("Poppins", size: 14))
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                }
                Image("BluetoothOnIllustration")
            }
        }.padding()
        
    }
}
struct SearchBluetoothDevices_Previews: PreviewProvider {
    static var previews: some View {
        SearchBluetoothDevices()
    }
}
