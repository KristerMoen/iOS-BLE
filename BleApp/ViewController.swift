//
//  ViewController.swift
//  BleApp
//
//  Created by Krister Sigvaldsen Moen on 13.03.2018.
//  Copyright © 2018 Krister Sigvaldsen Moen. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initLocalBeacon()

    }

    func initLocalBeacon() {
        
        if localBeacon != nil {
            stopLocalBeacon()
        }
        
        let localBeaconUUID = "e276c0c0-d740-52e8-b778-9ae6e514269e"
        let localBeaconMajor: CLBeaconMajorValue = 1
        let localBeaconMinor: CLBeaconMinorValue = 1
        
        let uuid = UUID(uuidString: localBeaconUUID)!
        localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "Kristers Beacon")
        
        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: -45)
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        

    }
    
    func stopLocalBeacon() {
        
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject]!)
           
        } else if peripheral.state == .poweredOff {
            stopLocalBeacon()
        }
    }


}

