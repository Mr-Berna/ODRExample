//
//  ODRManager.swift
//  ODRExample
//
//  Created by Eric Berna on 1/22/18.
//  Copyright © 2018 BathWraps. All rights reserved.
//

import Foundation

protocol ODRManagerDelegate: class {
	func doneLoading(tag: String, successfully: Bool)
}

class ODRManager {

	var delegate: ODRManagerDelegate?

	var requests = [NSBundleResourceRequest]()

	func load(tag: String) {
		let request = NSBundleResourceRequest(tags: [tag])
		requests.append(request)
		request.conditionallyBeginAccessingResources { (resourcesAvailable) in
			if resourcesAvailable {
				if let d = self.delegate {
					d.doneLoading(tag: tag, successfully: true)
				}
			} else {
				request.beginAccessingResources { (error) in
					if let err = error {
						self.delegate?.doneLoading(tag: tag, successfully: false)
						NSLog("Error accessing resource: %@", err.localizedDescription)
					} else {
						self.delegate?.doneLoading(tag: tag, successfully: true)
					}
				}
			}
		}
	}
	
}
