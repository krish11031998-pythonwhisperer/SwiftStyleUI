//
//  GlobalFunctions.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 08/09/2022.
//

import SwiftUI

func asyncMainAnimation(animation: Animation = .linear, completion: @escaping () -> Void) {
	DispatchQueue.main.async {
		withAnimation(animation, completion)
	}
}

func debug(_ val: Any) {
	print("(DEBUG) val : ", val)
}


