//
//  SlideZoomCardCarousel.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

struct SlideZoomCard: ViewModifier {
	
	let size: CGSize
	@State var scale: CGFloat = 1
	init(size: CGSize) {
		self.size = size
	}
	
	func scaleFactor(midX: CGFloat){
		scale = midX > .totalWidth * 0.75 ? 0.9 : 1
	}
	
	func body(content: Content) -> some View {
		GeometryReader { g -> AnyView in
			let midX = g.frame(in: .global).midX
			
			DispatchQueue.main.async {
				withAnimation {
					scaleFactor(midX: midX)
				}
			}
			
			let view = content
				.scaleEffect(scale)
			
			return AnyView(view)
		}
		.frame(size: size, alignment: .center)
	}
}

extension View {
	
	func slideZoomCard(size: CGSize) -> some View { modifier(SlideZoomCard(size: size)) }
}

struct SizePreferenceKey: PreferenceKey {
	
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}

struct SlideZoomScroll<Content: View>: View {
	
	@State var currentIdx: Int = .zero
	@State var off: CGFloat = .zero
	@State var size: CGSize = .zero
	
	let spacing: CGFloat
	let data: [Any]
	let cardBuilder: (Any) -> Content
	
	init(data: [Any], spacing: CGFloat = 10, @ViewBuilder cardBuilder: @escaping (Any) -> Content) {
		self.data = data
		self.cardBuilder = cardBuilder
		self.spacing = spacing
	}
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: spacing) {
				ForEach(Array(data.enumerated()), id: \.offset) { data in
					cardBuilder(data.element)
						.slideZoomCard(size: size)
				}
				Spacer().frame(size: .init(width: .totalWidth.half.half, height: 0))
			}
		}.onPreferenceChange(SizePreferenceKey.self) {
			if size != $0 {
				size = $0
			}
		}
	}
}


struct SlideZoomCardCarousel_Preview: PreviewProvider {
	
	static var previews: some View {
		SlideZoomScroll(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue]) { color in
			RoundedRectangle(cornerRadius: 20)
				.fill((color as? Color) ?? .red)
				.frame(width: 200, height: 200)
				.preference(key: SizePreferenceKey.self, value: .init(width: 200, height: 200))
		}
	}
}
