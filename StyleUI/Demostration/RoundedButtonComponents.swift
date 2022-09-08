//
//  RoundedButton.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import SwiftUI

struct RoundedButtonComponents: View {
	@State var showModal: Bool = false
	@State var showFullScreen: Bool = false
	
	var blobModel: RoundedButtonModel {
		var model: RoundedButtonModel = .testModelWithBlob
		model.handler = {
			self.showModal.toggle()
		}
		return model
	}
	
	var testModel: RoundedButtonModel {
		var model: RoundedButtonModel = .testModel
		model.handler = {
			self.showFullScreen.toggle()
		}
		return model
	}
	
	@ViewBuilder func modalView() -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center) {
				"Modal"
					.styled(font: .systemFont(ofSize: 25, weight: .bold), color: .black)
					.text
				Spacer()
				CustomButton(config: .init(imageName: .close, size: .init(squared: 10), foregroundColor: .blue, backgroundColor: .black)) {
					if showModal { showModal = false }
					if showFullScreen { showFullScreen = false }
				}
			}
			"This is a simple text that is being displayed, This is a simple text that is being displayed".text
			RoundedButton(model: .init(blob: .init(background: .red, padding: 10, cornerRadius: 10), handler: {
				if showModal { showModal = false }
				if showFullScreen { showFullScreen = false }
			}))
			.frame(height: 50, alignment: .topLeading)
			.padding(.top,10)
			
		}.padding()
	}
	
    var body: some View {
		ZStack(alignment: .bottom) {
			ScrollView(.vertical, showsIndicators: false) {
				LazyVStack(alignment: .center, spacing: 10) {
					RoundedButton(model: .testModelLeading)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Leading Image").padding().anyView)
					
					RoundedButton(model: .testModelTrailing)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Trailing Image").padding().anyView)
						
					RoundedButton(model: testModel)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/o Image").padding().anyView)
					
					RoundedButton(model: blobModel)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Blob").padding().anyView)
				}
			}
		}
		.slideInFromBottomModal(showModal: $showModal, modalConfig: .defaultConfig,modal: modalView)
		.fullScreenCover(isPresented: $showFullScreen) {
			modalView()
				.frame(maxWidth: .totalWidth, maxHeight: .totalHeight, alignment: .topLeading)
		}
		.edgesIgnoringSafeArea(.bottom)
		.navigationTitle("Rounded Button")
		.navigationBarTitleDisplayMode(.inline)
    }
}



struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonComponents()
    }
}
