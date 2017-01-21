//
//  ViewController.swift
//  iBeaconSender
//
//  Created by hirauchi.shinichi on 2017/01/21.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import Cocoa
import CoreLocation
import CoreBluetooth

class ViewController: NSViewController, CBPeripheralManagerDelegate {

    @IBOutlet weak var button: NSButtonCell!
    
    var manager: CBPeripheralManager!
    var beaconData: BeaconData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CBPeripheralManager(delegate: self, queue: nil)
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == CBPeripheralManagerState.poweredOn {
            
            let uuid = NSUUID.init(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
            let major = UInt16(1)
            let minor = UInt16(1)
            let measuredPower = Int8(-60)
            
            beaconData = BeaconData(proximityUUID: uuid, major: major, minor: minor, measuredPower: measuredPower)
        }
    }

    @IBAction func tapOnButton(_ sender: NSButton) {
        view.backgroundColor = NSColor.red
        manager.startAdvertising(beaconData.Advertisement() as! [String : Any]?)
    }
   
    @IBAction func tapOffButton(_ sender: NSButton) {
        view.backgroundColor = NSColor.windowBackgroundColor
        manager.stopAdvertising()
    }
}


extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}


