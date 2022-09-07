//
//  RoundedButton.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import SwiftUI

struct RoundedButtonComponents: View {
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVStack(alignment: .center, spacing: 10) {
				RoundedButton(model: Self.testModelLeading)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Leading Image").padding().anyView)
				
				RoundedButton(model: Self.testModelTrailing)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Trailing Image").padding().anyView)
					
				RoundedButton(model: Self.testModel)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/o Image").padding().anyView)
				
				RoundedButton(model: Self.testModelWithBlob)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Blob").padding().anyView)
			}
		}
		.navigationTitle("Rounded Button")
		.navigationBarTitleDisplayMode(.inline)
    }
}


extension RoundedButtonComponents {
	static var testModelLeading: RoundedButtonModel {
		let leadingImg = RoundedButtonModel.RoundedButtonImageModel(imgURL: UIImage.testImage, cornerRadius: 16)
		return .init(leadingImg: leadingImg,
					 topLeadingText: "Title".styled(font: .systemFont(ofSize: 15, weight: .semibold), color: .black),
					 bottomLeadingText: "SubTitle".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
					 topTrailingText: "Caption".styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black),
					 bottomTrailingText: "SubCaption".styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black))
		
	}

	static var testModelTrailing: RoundedButtonModel {
		let trailingImg = RoundedButtonModel.RoundedButtonImageModel(imgURL: UIImage.testImage, cornerRadius: 16)
		return .init(trailingImg: trailingImg,
					 topLeadingText: "Title".styled(font: .systemFont(ofSize: 15, weight: .semibold), color: .black),
					 bottomLeadingText: "SubTitle".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
					 topTrailingText: "Caption".styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black),
					 bottomTrailingText: "SubCaption".styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black))
		
	}

	static var testModel: RoundedButtonModel {
		return .init(topLeadingText: "Title".styled(font: .systemFont(ofSize: 15, weight: .semibold), color: .black),
					 bottomLeadingText: "SubTitle".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
					 topTrailingText: "Caption".styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black),
					 bottomTrailingText: "SubCaption".styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black))
		
	}

	static var testModelWithBlob: RoundedButtonModel {
		let leadingImg = RoundedButtonModel.RoundedButtonImageModel(imgURL: UIImage.testImage, cornerRadius: 16)
		let trailingImg = RoundedButtonModel.RoundedButtonImageModel(imgURL: UIImage.testImage, cornerRadius: 16)
		return .init(leadingImg: leadingImg,
					 trailingImg: trailingImg,
					 topLeadingText: "Title".styled(font: .systemFont(ofSize: 15, weight: .semibold), color: .black),
					 bottomLeadingText: "SubTitle".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
					 topTrailingText: "Caption".styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black),
					 bottomTrailingText: "SubCaption".styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black),
					 blob: RoundedButtonModel.RoundedButtonBlob(background: .black.opacity(0.05), padding: 15, cornerRadius: 20))
		
	}
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonComponents()
    }
}
