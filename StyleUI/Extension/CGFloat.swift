//
//  CGFloat.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import Foundation
import SwiftUI

extension CGFloat {
	static var totalWidth: CGFloat { UIScreen.main.bounds.width }
	static var totalHeight: CGFloat { UIScreen.main.bounds.height }
	
	var half: Self { self * 0.5 }
	
	func boundedTo(lower: Self = 0, higher: Self = 1) -> Self { self < lower ? lower : self > higher ? higher : self }
}

extension ClosedRange where Bound == CGFloat {
	
	func normalize(_ val: CGFloat) -> CGFloat {
		let max = upperBound
		let min = lowerBound
		
		return (val - min)/(max - min)
	}
}
