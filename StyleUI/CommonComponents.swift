//
//  CommonComponents.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

struct Container<Content: View>: View {
	var header: String
	var actionText: String?
	var action: (() -> Void)?
	var innerView: Content
	
	init(heading: String, actionText: String? = nil, @ViewBuilder view: @escaping () -> Content, action: (() -> Void)? = nil) {
		self.header = heading
		self.actionText = actionText
		self.action = action
		self.innerView = view()
	}
	
	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			HStack(alignment: .center, spacing: 10) {
				header.styled(font: .systemFont(ofSize: 15, weight: .semibold), color: .black).text
				Spacer()
				if let validActionText = actionText {
					validActionText.styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black).text
				}
			}
			innerView
		}
	}
}
