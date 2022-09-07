//
//  CGS.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI


//MARK: - Size Preference Key

struct SizePreferenceKey: PreferenceKey {
	
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}


//MARK: - CGSize Extension

extension CGSize {
	init(squared: CGFloat) {
		self.init(width: squared, height: squared)
	}
}
