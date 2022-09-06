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

extension NSAttributedString: RenderableText {
	
	var text: Text {
		.init(.init(self))
	}
}

extension String: RenderableText {
	
	var text: Text {
		.init(self)
	}
	
	func styled(font: UIFont,color: Color) -> RenderableText {
		var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : font]
		attributes[NSAttributedString.Key.foregroundColor] = color
		
		return NSAttributedString(string: self, attributes: attributes)
	}
}
