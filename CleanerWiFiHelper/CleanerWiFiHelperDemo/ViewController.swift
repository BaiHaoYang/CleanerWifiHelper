//
//  ViewController.swift
//  CleanerWiFiHelperDemo
//
//  Created by Ke Yang on 02/12/2016.
//  Copyright © 2016 com.sangebaba. All rights reserved.
//

import UIKit
import CleanerWiFiHelper

class ViewController: UIViewController {

	var ssid = "Xiuxiu2G"
	var pwd = "xiuxiu910"
	var helper: CleanerWiFiHelper?

	override func viewDidLoad() {
		super.viewDidLoad()

		helper = CleanerWiFiHelper()
		print("\(helper) is ready")
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		helper?.sendData(ssid: ssid, password: pwd, success: { (info) -> Void in
			print(info.mac)
		}, failure: { (error) -> Void in
			print(error)
		})
		print("\(helper) is now sending data: \(ssid):\(pwd)")
	}

}

