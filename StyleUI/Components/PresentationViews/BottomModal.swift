//
//  BottomModal.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 08/09/2022.
//

import SwiftUI

//MARK: - TransitionFromEdge
struct TransitionFromEdge: ViewModifier {
	
	let edge: Edge
	
	func body(content: Content) -> some View {
		content
			.edgesIgnoringSafeArea(Edge.Set(edge))
			.transition(.move(edge: edge))
	}
}

extension View {
	
	func transitionFrom(_ edge:Edge) -> some View {
		modifier(TransitionFromEdge(edge: edge))
	}
}

//MARK: - SlideInFromBottom ViewModifier

struct ModalConfig {
	let bgColor: Color
	let dimmingBG: Color
	let cornerRadius: CGFloat
	
	var maxHeight: CGFloat {
		.totalHeight * 0.75
	}
	
	static var defaultConfig: Self {
		.init(bgColor: .white, dimmingBG: .black, cornerRadius: 16)
	}
}

struct SlideInFromBottom<Modal: View>: ViewModifier {
	@Binding var showModal: Bool
	@State var modalHeight: CGFloat = .zero
	@State var dynamicHeight: CGFloat = .zero
	let modal: Modal
	let modalConfig: ModalConfig
	
	init(showModal: Binding<Bool>, modalConfig: ModalConfig = .defaultConfig, @ViewBuilder modal: @escaping () -> Modal) {
		self._showModal = showModal
		self.modalConfig = modalConfig
		self.modal = modal()
	}

	
	var modalViewBuilder: some View {
		modal
		.padding(.bottom, .safeAreaInsets.bottom)
		.frame(width: .totalWidth, alignment: .topLeading)
		.background(modalConfig.bgColor)
		.clipShape(RoundedRectangle(cornerRadius: modalConfig.cornerRadius))
		.transitionFrom(.bottom)
	}
	
	func body(content: Content) -> some View {
		ZStack(alignment: .bottom) {
			content
			modalConfig.dimmingBG.opacity(showModal ? 0.15 : 0)
			if showModal {
				modalViewBuilder
			}
		}
	}
}

extension View {
	
	func slideInFromBottomModal<Modal:View>(showModal: Binding<Bool>,
											modalConfig: ModalConfig = .defaultConfig,
											@ViewBuilder modal: @escaping () -> Modal) -> some View
	{
		modifier(SlideInFromBottom(showModal: showModal, modalConfig: modalConfig, modal: {
			modal()
		}))
	}
}


struct BottomModal_Previews: PreviewProvider {
    static var previews: some View {
		Color.blue
			.frame(width: .totalWidth, height: .totalHeight, alignment: .center)
			.edgesIgnoringSafeArea(.all)
    }
}
