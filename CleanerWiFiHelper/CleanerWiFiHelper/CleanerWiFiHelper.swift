//
//  CleanerWiFiHelper.swift
//  CleanerWiFiHelper
//
//  Created by Ke Yang on 02/12/2016.
//  Copyright © 2016 com.sangebaba. All rights reserved.
//

import Foundation

@objc public enum CleanerWiFiHelperError: Int, Error {
	case unknown = 0
	case timedOut
}

public class CleanerWiFiHelper: NSObject {
	public static var timeOutDuration: TimeInterval = 45.0
	var easyConfig: EasyConfig!
	var success: ((CleanerWiFiInfo) -> Void)?
	var failure: ((CleanerWiFiHelperError) -> Void)?
	var timedOut = true

//	public override init() {
//		super.init()
//		easyConfig = EasyConfig.init(self)
//	}

	@objc public func sendData(ssid: String, password: String?, success: ((CleanerWiFiInfo) -> Void)?, failure: ((CleanerWiFiHelperError) -> Void)?) {
		easyConfig = EasyConfig.init(self)
		easyConfig.sendData(withPsk: password, andSSID: ssid)
		self.success = success
		self.failure = failure
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + CleanerWiFiHelper.timeOutDuration, execute: { () -> Void in
			if self.timedOut {
				self.easyConfig.stop_send()
				self.failure?(CleanerWiFiHelperError.timedOut)
			}
		})
	}
}

public class CleanerWiFiInfo: NSObject {
	public private(set) var ip: String
	public private(set) var mac: String
	public private(set) var name: String
	init(ip: String, mac: String, name: String) {
		self.ip = ip
		self.mac = mac
		self.name = name
		super.init()
	}
}

// MARK: -
extension CleanerWiFiHelper: EasyConfigDelegate {

	public func recv(with recvPacket: RecvPacket!) {
		timedOut = false
		easyConfig.stop_send()
		let info = CleanerWiFiInfo(ip: recvPacket.module_ip, mac: recvPacket.module_mac, name: recvPacket.module_name)
		success?(info)
	}
}
