//
//  AvertisementData.swift
//  iBeaconSender
//
//  Created by hirauchi.shinichi on 2017/01/21.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import CoreLocation

final class BeaconData: NSObject {

    var advertisement: NSDictionary!
    
    init(proximityUUID: UUID?, major: UInt16?, minor: UInt16?, measuredPower: Int8?) {
        var buffer = [CUnsignedChar](repeating: 0, count: 21)
        (proximityUUID! as NSUUID).getBytes(&buffer)
        buffer[16] = CUnsignedChar(major! >> 8)
        buffer[17] = CUnsignedChar(major! & 255)
        buffer[18] = CUnsignedChar(minor! >> 8)
        buffer[19] = CUnsignedChar(minor! & 255)
        buffer[20] = CUnsignedChar(bitPattern: measuredPower!)
        let data = NSData(bytes: buffer, length: buffer.count)
        advertisement = NSDictionary(object: data, forKey: "kCBAdvDataAppleBeaconKey" as NSCopying)
    }
}


