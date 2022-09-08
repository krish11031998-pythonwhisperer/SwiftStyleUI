//
//  Button.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI


//MARK: = Image Extension

extension Image {
	
	enum Catalogue: String {
		case back = "arrow.left"
		case next = "arrow.right"
	}
}

extension Image.Catalogue {
	var image: Image { .init(systemName: rawValue) }
}


// MARK: - CustomButton

struct CustomButtonConfig {
	let imageName: Image.Catalogue
	let text: String?
	let size: CGSize
	let foregroundColor: Color
	let backgroundColor: Color
	let action: () -> Void
	
	init(imageName: Image.Catalogue, text: String? = nil, size: CGSize = .init(squared: 15), foregroundColor: Color = .white, backgroundColor: Color = .black, action: @escaping () -> Void) {
		self.imageName = imageName
		self.text = text
		self.size = size
		self.foregroundColor = foregroundColor
		self.backgroundColor = backgroundColor
		self.action = action
	}
}

struct CustomButton: View {
	
	let config: CustomButtonConfig
	
	init(config: CustomButtonConfig) {
		self.config = config
	}
	
	var body: some View {
		Button(action: config.action) {
			HStack(alignment: .center, spacing: 5) {
				config.imageName.image
					.resizable()
					.scaledToFit()
					.foregroundColor(config.foregroundColor)
					.frame(size: config.size)
					.padding(5)
					.background(config.backgroundColor)
					.clipShape(Circle())
				if let validText = config.text {
					validText.text
				}
			}
		}
		.buttonStyle(CustomButtonStyle())
	}
}

// MARK: - CustomButtonModifier

struct CustomButtonStyle: ButtonStyle {
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.9 : 1)
	}	
}


//MARK: - ButtonViewModifier

struct ButtonViewModifier: ViewModifier {
	
	let handler: () -> Void
	
	init(handler: @escaping () -> Void) {
		self.handler = handler
	}
	
	
	func body(content: Content) -> some View {
		Button {
			withAnimation(.easeInOut, handler)
		} label: {
			content
		}.buttonStyle(CustomButtonStyle())
	}
}

extension View {
	
	func buttonify(action: @escaping () -> Void) -> some View {
		modifier(ButtonViewModifier(handler: action))
	}
}
