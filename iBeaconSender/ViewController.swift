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

    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    var manager: CBPeripheralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CBPeripheralManager(delegate: self, queue: nil)
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == CBPeripheralManagerState.poweredOn {
            // 使用可能なのでボタンを有効にする
            startButton.isEnabled = true
            stopButton.isEnabled = true
        }
    }

    @IBAction func tapStartButton(_ sender: Any) {
        view.backgroundColor = NSColor.red
        
//        let uuid = UUID.init(uuidString: "myuuid")
//        let beaconRegion = CLBeaconRegion.init(proximityUUID: uuid!, major: 0, minor: 0, identifier: "jp.classmethod.myregion")
//        let beaconData = NSDictionary(dictionary: beaconRegion.peripheralData(withMeasuredPower: nil))
//        manager.startAdvertising(beaconData as? [String : Any] )
        
        
        let uuid = UUID.init(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
        let beaconData = BeaconData(proximityUUID: uuid, major: 1, minor: 1, measuredPower: -60)
        manager.startAdvertising(beaconData.advertisement as! [String : Any]?)
    }
    @IBAction func tapStopButton(_ sender: Any) {
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


