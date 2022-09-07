//
//  View.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import Foundation
import SwiftUI

//MARK: - View

extension View {
	
	func asyncMainAnimation(animation: Animation = .linear, completion: @escaping () -> Void) {
		DispatchQueue.main.async {
			withAnimation(animation, completion)
		}
	}
	
	func frame(size: CGSize, alignment: Alignment = .center) -> some View {
		self.frame(width: size.width, height: size.height, alignment: alignment)
	}
	
	var anyView: AnyView { .init(self) }
}

//MARK: - Clipping Content

struct ClipContent: ViewModifier {
	var radius: CGFloat
	func body(content: Content) -> some View {
		content
			.contentShape(RoundedRectangle(cornerRadius: radius))
			.clipShape(RoundedRectangle(cornerRadius: radius))
	}
}

extension View {
	
	func clipContent(radius: CGFloat) -> some View {
		modifier(ClipContent(radius: radius))
	}
}


//MARK: - Navigation Stack

struct CustomNavigatonStyle: ViewModifier {

	init(navbarAppearance: UINavigationBarAppearance) {
		UINavigationBar.appearance().standardAppearance = navbarAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navbarAppearance
		UINavigationBar.appearance().compactAppearance = navbarAppearance
	}
	
	init(standardAppearance: UINavigationBarAppearance,
		 scrollEdgeAppearance: UINavigationBarAppearance,
		 compactAppearance: UINavigationBarAppearance) {
		UINavigationBar.appearance().standardAppearance = standardAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
		UINavigationBar.appearance().compactAppearance = compactAppearance
	}
	
	func body(content: Content) -> some View {
		NavigationView {
			content
		}.navigationViewStyle(StackNavigationViewStyle())
	}
	
}

extension View {
	
	func customNavbarAppearance(navbarAppearance: UINavigationBarAppearance) -> some View {
		modifier(CustomNavigatonStyle(navbarAppearance: navbarAppearance))
	}
	
	func customNavbarAppearance(standardAppearance: UINavigationBarAppearance,
								scrollEdgeAppearance: UINavigationBarAppearance,
								compactAppearance: UINavigationBarAppearance) -> some View {
		modifier(CustomNavigatonStyle(standardAppearance: standardAppearance, scrollEdgeAppearance: scrollEdgeAppearance, compactAppearance: compactAppearance))
	}
}

//MARK: - View Custom Extension

struct Blobify: ViewModifier {
	let background: Color
	let padding: CGFloat
	let cornerRadius: CGFloat
	
	init(background: Color = .clear, padding: CGFloat = 10, cornerRadius: CGFloat = 8) {
		self.background = background
		self.padding = padding
		self.cornerRadius = cornerRadius
	}
	
	func body(content: Content) -> some View {
		content
			.padding(padding)
			.background(background)
			.clipContent(radius: cornerRadius)
	}
	
}

extension View {
	
	func blobify(background: Color = .clear, padding: CGFloat = 10, cornerRadius: CGFloat)  -> some View {
		modifier(Blobify(background: background, padding: padding, cornerRadius: cornerRadius))
	}
	
	@ViewBuilder func isHidden(_ condition: Bool) -> some View {
		if condition {
			self
		} else {
			Color.clear.frame(size: .zero)
		}
	}
}
