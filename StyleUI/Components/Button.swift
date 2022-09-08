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
		case close = "xmark"
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
	
	init(imageName: Image.Catalogue, text: String? = nil, size: CGSize = .init(squared: 10), foregroundColor: Color = .white, backgroundColor: Color = .black) {
		self.imageName = imageName
		self.text = text
		self.size = size
		self.foregroundColor = foregroundColor
		self.backgroundColor = backgroundColor
	}
}

struct CustomButton: View {
	
	let config: CustomButtonConfig
	let action: Callback?
	
	init(config: CustomButtonConfig, action: Callback? = nil) {
		self.config = config
		self.action = action
	}
	
	var body: some View {
		HStack(alignment: .center, spacing: 5) {
			config.imageName.image
				.resizable()
				.scaledToFit()
				.foregroundColor(config.foregroundColor)
				.frame(size: config.size)
				.padding(10)
				.background(config.backgroundColor)
				.clipShape(Circle())
			if let validText = config.text {
				validText.text
			}
		}
		.buttonify {
			action?()
		}
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
	let animation: Animation
	
	init(animation: Animation, handler: @escaping () -> Void) {
		self.handler = handler
		self.animation = animation
	}
	
	
	func body(content: Content) -> some View {
		Button {
			asyncMainAnimation(animation: animation, completion: handler)
		} label: {
			content
		}.buttonStyle(CustomButtonStyle())
	}
}

extension View {
	
	func buttonify(animation: Animation = .default ,action: @escaping () -> Void) -> some View {
		modifier(ButtonViewModifier(animation: animation, handler: action))
	}
}
