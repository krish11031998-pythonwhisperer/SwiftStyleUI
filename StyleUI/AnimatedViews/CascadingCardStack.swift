//
//  CascadingCardStack.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

//typealias CascadingCardData = Any

extension Int {
	
	var abs: Self { Swift.abs(self) }
	var cgFloat: CGFloat { CGFloat(self) }
	var double: Double { Double(self) }
}

struct CascadingCard: ViewModifier {
	
	let limit: Int
	let delta: Int
	let offFactor: CGFloat
	let pivotFactor: CGFloat
	
	init(limit: Int, delta: Int, offFactor: CGFloat = 50, pivotFactor: CGFloat = 10) {
		self.limit = limit
		self.delta = delta
		self.offFactor = offFactor
		self.pivotFactor = pivotFactor
	}
	
	var pivot: Angle { Angle(degrees: delta == 0 ? 0 : pivotFactor * delta.double) }
	var off: CGFloat { delta.cgFloat * offFactor }
	var scale: CGFloat { delta == .zero ? 1 : 1 - (0.15 * delta.abs.cgFloat) }
	
	func body(content: Content) -> some View {
		content
			.offset(x: off)
			.scaleEffect(scale)
			.rotation3DEffect(-pivot, axis: (x: 0, y: 1, z: 0), anchor: .center, anchorZ: 0.0, perspective: 1)
			.zIndex(delta == 0 ? 1 : -delta.abs.double)
			
	}
}


extension View {
	
	func cascadingCard(limit: Int, delta: Int, offFactor: CGFloat = 50, pivotFactor: CGFloat = 10) -> some View {
		modifier(CascadingCard(limit: limit, delta: delta, offFactor: offFactor, pivotFactor: pivotFactor))
	}
}

struct CascadingCardStack<Content: View>: View {
	
	@State var currentIdx: Int
	@State var offset: CGFloat = .zero
	@State var off: CGFloat = .zero
	
	
	let data: [Any]
	let viewBuilder: (Any) -> Content
	let offFactor: CGFloat
	let pivotFactor: CGFloat
	
	init(data: [Any], offFactor: CGFloat = 50, pivotFactor: CGFloat = 10, @ViewBuilder viewBuilder: @escaping (Any) -> Content) {
		self.data = data
		_currentIdx = .init(initialValue: Int(Double(data.count) * 0.5))
		self.viewBuilder = viewBuilder
		self.offFactor = offFactor
		self.pivotFactor = pivotFactor
	}
	
	func change(_ value: DragGesture.Value) {
		let xOff = value.translation.width
		asyncMainAnimation(animation: .easeInOut) {
			if abs(xOff) <= 20 {
				self.off = xOff
			}
		}
	}
	
	func end(_ value: DragGesture.Value) {
		let xOff = value.translation.width
		asyncMainAnimation(animation: .easeInOut) {
			let delta = (xOff > 0 ? -1 : 1)
			if abs(xOff) >= 25, self.currentIdx + delta >= 0 && self.currentIdx + delta <= self.data.count - 1 {
				print("(DEBUG) currentIdx : \(self.currentIdx + delta), xOff: \(xOff) and delta : \(delta)")
				self.currentIdx += delta
			}
			self.off = .zero
		}
	}
	
	var body: some View {
		ZStack(alignment: .center) {
			ForEach(Array(data.enumerated()), id: \.offset) { data in
				
				let delta = data.offset - currentIdx
				
				if data.offset >= currentIdx - 2 &&  data.offset <= currentIdx + 2 {
					viewBuilder(data.element)
						.cascadingCard(limit: 2, delta: delta, offFactor: offFactor, pivotFactor: pivotFactor)
				}
			}
		}
		.offset(x: off)
		.gesture(DragGesture().onChanged(change(_:)).onEnded(end(_:)))
		.onAppear {
			print("(DEBUG) currentIdx : ",self.currentIdx)
		}
	}
}


struct CascadingCardStack_Preview: PreviewProvider {
	
	static var previews: some View {
		CascadingCardStack(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue]) { color in
			RoundedRectangle(cornerRadius: 20)
				.fill((color as? Color) ?? .red)
				.frame(width: 200, height: 350)
		}
	}
}
