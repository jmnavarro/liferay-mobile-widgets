/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit

class ViewController: UIViewController, LoginWidgetDelegate {

	@IBOutlet var widget: LoginWidget?

    
    // UIViewController METHODS
    
    
	override func viewDidLoad() {
		super.viewDidLoad()

		// WORKAROUND!
		// Delegate assignment in IB doesn't work!!
		if widget {
			widget!.delegate = self
			widget!.setAuthType(AuthType.Email)
		}

			/*
			if LoginWidget.storedSession() {
				loginWidget.hidden = true
			}
			else {
				loginWidget.becomeFirstResponder()
			}
*/
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

    
    // LoginWidgetDelegate METHODS

    
	func onCredentialsLoaded(session:LRSession) {
		print("Saved loaded for server " + session.server)
 	}

	func onCredentialsSaved(session:LRSession) {
		print("Saved credentials for server " + session.server)
 	}
 
 	func onLoginError(error: NSError)  {
 		println("Error -> " + error.description)
	}

	func onLoginResponse(attributes: [String:AnyObject])  {
		NSLog("Login %@", attributes)
	}

}

