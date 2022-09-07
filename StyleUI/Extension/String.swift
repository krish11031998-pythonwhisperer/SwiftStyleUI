//
//  String.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

protocol RenderableText {
	var text: Text { get }
}

extension AttributedString: RenderableText {
	
	var text: Text { .init(self) }
}

extension String: RenderableText {
	
	var text: Text {
		.init(self)
	}
	
	func styled(font: UIFont, color: Color) -> RenderableText {
		var attributedString = AttributedString(self)
		attributedString.font = font
		attributedString.foregroundColor = color
		
		return attributedString
	}
}
