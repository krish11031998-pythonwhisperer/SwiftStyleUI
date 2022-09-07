//
//  RoundedButton.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI

typealias Callback = () -> Void

struct RoundedButtonModel {
	
	struct RoundedButtonImageModel {
		let img: UIImage?
		let imgUrl: String?
		let size: CGSize
		let cornerRadius: CGFloat
		
		init(img: UIImage? = nil,
			 imgURL: String? = nil,
			 size: CGSize = .init(squared: 50),
			 cornerRadius: CGFloat = 8)
		{
			self.img = img
			self.imgUrl = imgURL
			self.size = size
			self.cornerRadius = cornerRadius
		}
	}
	
	struct RoundedButtonBlob {
		let backgroundColor: Color
		let padding: CGFloat
		let cornerRadius: CGFloat
		
		init(background: Color = .white, padding: CGFloat = 10, cornerRadius: CGFloat = 8) {
			self.backgroundColor = background
			self.padding = padding
			self.cornerRadius = cornerRadius
		}
	}
	
	let leadingImg: RoundedButtonImageModel?
	let trailingImg: RoundedButtonImageModel?
	let topLeadingText: RenderableText?
	let bottomLeadingText: RenderableText?
	let topTrailingText: RenderableText?
	let bottomTrailingText: RenderableText?
	let blob: RoundedButtonBlob?
	let handler: Callback?

	
	init(
		leadingImg: RoundedButtonImageModel? = nil,
		trailingImg: RoundedButtonImageModel? = nil,
		topLeadingText: RenderableText? = nil,
		bottomLeadingText: RenderableText? = nil,
		topTrailingText: RenderableText? = nil,
		bottomTrailingText: RenderableText? = nil,
		blob: RoundedButtonBlob? = nil,
		handler: Callback? = nil)
	{
		self.leadingImg = leadingImg
		self.trailingImg = trailingImg
		self.topLeadingText = topLeadingText
		self.bottomLeadingText = bottomLeadingText
		self.topTrailingText = topTrailingText
		self.bottomTrailingText = bottomTrailingText
		self.blob = blob
		self.handler = handler
	}
}

struct RoundedButton: View {

	let model: RoundedButtonModel
	
	init(model: RoundedButtonModel) {
		self.model = model
	}
	
	var leadingStack: some View {
		VStack(alignment: .leading) {
			if let validTopLeadingText = model.topLeadingText {
				validTopLeadingText.text
			}
			Spacer()
			if let validBottomLeadingText = model.bottomLeadingText {
				validBottomLeadingText.text
			}
		}
	}
	
	var trailingStack: some View {
		VStack(alignment: .trailing) {
			if let validTopTrailingText = model.topTrailingText {
				validTopTrailingText.text
			}
			Spacer()
			if let validBottomTrailingText = model.bottomTrailingText {
				validBottomTrailingText.text
			}
		}
	}
	
	
	var mainButton: some View {
		HStack(alignment: .center, spacing: 10) {
			if model.leadingImg != nil {
				ImageView(url: model.leadingImg?.imgUrl, img: model.leadingImg?.img)
					.frame(size: model.leadingImg?.size ?? .regularSize)
					.clipContent(radius: model.leadingImg?.cornerRadius ?? 0)
			}
			leadingStack
			Spacer()
			trailingStack
			if model.trailingImg != nil {
				ImageView(url: model.trailingImg?.imgUrl, img: model.trailingImg?.img)
					.frame(size: model.trailingImg?.size ?? .regularSize)
					.clipContent(radius: model.trailingImg?.cornerRadius ?? 0)
			}
		}
		
	}
	
	var body: some View {
		if let blob = model.blob {
			mainButton
				.blobify(background: blob.backgroundColor, padding: blob.padding, cornerRadius: blob.cornerRadius)
				.buttonify {
					model.handler?()
				}
		} else {
			mainButton
				.contentShape(Rectangle())
				.buttonify {
					model.handler?()
				}
		}
	}
	
	
}
