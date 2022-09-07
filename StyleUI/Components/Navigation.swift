//
//  Navigation.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI

//MARK: - Navigation Modifier

struct NavigationModifier: ViewModifier {
	
	@Binding var isActive: Bool
	
	init(isActive: Binding<Bool>) {
		self._isActive = isActive
	}
	
	func body(content: Content) -> some View {
		NavigationLink(isActive: $isActive) {
			content
		} label: {
			Color.clear
		}
	}
}

extension View {
	
	func navigationLink(isActive: Binding<Bool>) -> some View {
		self.modifier(NavigationModifier(isActive: isActive))
	}
}

// MARK: - NavLink
struct NavLink<Content: View>: View {
	
	@Binding var isActive: Bool
	let content: Content
	let leadingBarItem: AnyView?
	let trailingBarItem: AnyView?
	
	init(isActive: Binding<Bool>, leadingBarItem: (() -> AnyView)? = nil, trailingBarItem: (() -> AnyView)? = nil, @ViewBuilder _ view: @escaping () -> Content) {
		self._isActive = isActive
		self.content = view()
		self.leadingBarItem = leadingBarItem?()
		self.trailingBarItem = trailingBarItem?()
	}
	
	var body: some View {
		NavigationLink(isActive: $isActive) {
			content
				.navigationBarItems(leading: leadingBarItem ?? defaultBackButton, trailing: trailingBarItem)
				.navigationBarBackButtonHidden(true)
		} label: {
			Color.clear.frame(size: .zero)
		}

	}
	
}

extension NavLink {
	
	var defaultBackButton: AnyView {
		let cofig: CustomButtonConfig = .init(imageName: .back, size: .init(squared: 15), foregroundColor: .white, backgroundColor: .black) {
			asyncMainAnimation {
				self.isActive.toggle()
			}
		}
		
		return CustomButton(config: cofig).anyView
	}
}
