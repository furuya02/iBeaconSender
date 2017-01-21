//
//  AvertisementData.swift
//  iBeaconSender
//
//  Created by hirauchi.shinichi on 2017/01/21.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import Foundation
import CoreLocation
//import CoreBluetooth

final class BeaconData: NSObject {
    fileprivate var proximityUUID: NSUUID
    fileprivate var major:  CLBeaconMajorValue
    fileprivate var minor: CLBeaconMinorValue
    fileprivate var measuredPower: Int8
    
    init(proximityUUID: NSUUID?, major: CLBeaconMajorValue?, minor: CLBeaconMinorValue?, measuredPower: Int8?) {
        self.proximityUUID = proximityUUID!
        self.major = major!
        self.minor = minor!
        self.measuredPower = measuredPower!
    }
    
    func Advertisement() -> NSDictionary? {
        let bufferSize = 21
        var buffer = [CUnsignedChar](repeating: 0, count: bufferSize)
        
        proximityUUID.getBytes(&buffer)
        buffer[16] = CUnsignedChar(major >> 8)
        buffer[17] = CUnsignedChar(major & 255)
        buffer[18] = CUnsignedChar(minor >> 8)
        buffer[19] = CUnsignedChar(minor & 255)
        buffer[20] = CUnsignedChar(bitPattern: measuredPower)
        let data = NSData(bytes: buffer, length: bufferSize)
        
        return NSDictionary(object: data, forKey: "kCBAdvDataAppleBeaconKey" as NSCopying)
    }
}


