//
//  CommonComponents.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

struct EmptyView: View {
	
	var body: some View {
		Color.clear
			.frame(size: .zero)
	}
}

struct ContainerViewModifier:ViewModifier {
	
	var header: AnyView
	var footer: AnyView
	
	init(header: AnyView, footer: AnyView) {
		self.header = header
		self.footer = footer
	}
	
	
	func body(content: Content) -> some View {
		Section {
			content
		} header: { header } footer: { footer }
	}
}

extension View {
	
	func containerize(header: AnyView = EmptyView().anyView, footer: AnyView = EmptyView().anyView) -> some View {
		modifier(ContainerViewModifier(header: header, footer: footer))
	}
}

