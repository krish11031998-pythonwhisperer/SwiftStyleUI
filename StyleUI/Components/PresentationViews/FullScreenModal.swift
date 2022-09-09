//
//  FullScreenModal.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 09/09/2022.
//

import Foundation
import SwiftUI

//MARK: - FullScreen Modal

struct FullScreenModal<InnerContent: View>: ViewModifier {
	
	@Binding var isActive: Bool
	let isDraggable: Bool
	let innerContent: InnerContent
	@State var dragIndicator: CGFloat = .zero
	
	init(isActive: Binding<Bool>, isDraggable: Bool =  false, @ViewBuilder innerContent: @escaping () -> InnerContent) {
		self._isActive = isActive
		self.isDraggable = isDraggable
		self.innerContent = innerContent()
	}
	
	var dragGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				guard value.translation.height > 0  else { return }
				asyncMainAnimation {
					self.dragIndicator = value.translation.height
				}
			}
			.onEnded { value in
				asyncMainAnimation {
					guard value.translation.height > 20 else {
						self.dragIndicator = .zero
						return
					}
					
					self.dragIndicator = .zero
					self.isActive.toggle()
				}
			}
	}
	
	var destinationView: some View {
		ZStack(alignment: .top) {
			innerContent
			if isDraggable {
				Capsule()
					.fill(Color.gray)
					.frame(size: .init(width: 100, height: 20))
					.fillWidth(alignment: .center)
					.gesture(dragGesture)
			} else {
				CustomButton(config: .init(imageName: .close, size: .init(squared: 15), foregroundColor: .black, backgroundColor: .white)) {
					self.isActive.toggle()
				}
				.padding()
				.padding(.top, .safeAreaInsets.top)
				.fillWidth(alignment: .trailing)
			}
		}
		.fillFrame(alignment: .top)
	}
	
	func body(content: Content) -> some View {
		content
			.fullScreenCover(isPresented: $isActive) {
				destinationView
			}
	}
	
}

extension View {
	
	func fullScreenModal<InnerContent: View>(isActive: Binding<Bool>,
											 isDraggable: Bool =  false,
											 @ViewBuilder innerContent: @escaping () -> InnerContent) -> some View {
		modifier(FullScreenModal(isActive: isActive, isDraggable: isDraggable, innerContent: { innerContent() }))
	}
}
