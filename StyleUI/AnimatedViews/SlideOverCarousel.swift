//
//  SlideOverCarousel.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import Foundation
import SwiftUI

struct SlideCard: ViewModifier {
	
	var isPrev: Bool
	var isNext: Bool
	
	init(isPrev: Bool, isNext: Bool) {
		self.isPrev = isPrev
		self.isNext = isNext
	}
	
	var offset: CGFloat {
		isNext ? .totalWidth : 0
	}
	
	var scale: CGFloat {
		isPrev ? 0.9 : 1
	}
	
	func body(content: Content) -> some View {
		content
			.offset(x: offset)
			.scaleEffect(scale)
	}
}

extension View {
	
	func slideCard(isPrev: Bool, isNext: Bool) -> some View {
		self.modifier(SlideCard(isPrev: isPrev, isNext: isNext))
	}
}

struct SlideOverCarousel<Content: View>: View {
	
	var data: [Any]
	var viewBuilder: (Any) -> Content
	@State var currentIdx: Int = .zero
	
	init(data: [Any], @ViewBuilder viewBuilder: @escaping (Any) -> Content) {
		self.data = data
		self.viewBuilder = viewBuilder
	}

	
	@ViewBuilder func cardBuilder(data: Any) -> some View {
		
		if let color = data as? Color {
			RoundedRectangle(cornerRadius: 20)
				.fill(color)
				.frame(width: .totalWidth - 20, height: 200, alignment: .center)
		} else {
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.black)
				.frame(width: .totalWidth - 20, height: 200, alignment: .center)
		}
	}
	
	private func handleTap() {
		asyncMainAnimation {
			currentIdx = currentIdx == data.count - 1 ? 0 : currentIdx + 1
		}
	}
	
	var body: some View {
		ZStack(alignment: .center) {
			ForEach(Array(data.enumerated()), id: \.offset) { data in
				if data.offset >= currentIdx - 1 && data.offset <= currentIdx + 1 {
					viewBuilder(data.element)
						.onTapGesture (perform: handleTap)
						.slideCard(isPrev: data.offset == currentIdx - 1, isNext: data.offset == currentIdx + 1)
				}
			}
		}
	}
}

struct SlideOverCarouselPreviewProvider: PreviewProvider {
	static var previews: some View {
		SlideOverCarousel(data:[Color.red, Color.blue, Color.brown, Color.mint]) { color in
			RoundedRectangle(cornerRadius: 20)
				.fill((color as? Color) ?? .black)
				.frame(width: .totalWidth - 20, height: 200, alignment: .center)
		}
	}
}
