//
//  View.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import Foundation
import SwiftUI

//MARK: - Animation

extension View {
	
	func asyncMainAnimation(animation: Animation = .linear, completion: @escaping () -> Void) {
		DispatchQueue.main.async {
			withAnimation(animation, completion)
		}
	}
	
	func frame(size: CGSize, alignment: Alignment = .center) -> some View {
		self.frame(width: size.width, height: size.height, alignment: alignment)
	}
}
