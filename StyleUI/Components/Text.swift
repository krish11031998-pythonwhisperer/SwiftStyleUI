//
//  Text.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI

//MARK: - Head SubHead View

struct HeaderSubHeadView: View {
	
	let title: String
	let subTitle: String
	let spacing: CGFloat
	let alignment: Alignment
	
	init(title: String, subTitle: String, spacing: CGFloat = 10, alignment: Alignment = .leading) {
		self.title = title
		self.subTitle = subTitle
		self.spacing = spacing
		self.alignment = alignment
	}
	
	var body: some View {
		VStack(alignment: alignment.horizontal, spacing: 10) {
			title.styled(font: .boldSystemFont(ofSize: 15), color: .black).text
			subTitle.styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black).text
		}
	}
}


//MARK: -  Head Caption View

struct HeaderCaptionView: View {
	
	let title: String
	let subTitle: String
	let spacing: CGFloat
	let alignment: Alignment
	
	init(title: String, subTitle: String, spacing: CGFloat = 10, alignment: Alignment = .leading) {
		self.title = title
		self.subTitle = subTitle
		self.spacing = spacing
		self.alignment = alignment
	}
	
	var body: some View {
		HStack(alignment: alignment.vertical, spacing: 10) {
			title.styled(font: .boldSystemFont(ofSize: 15), color: .black).text
			Spacer()
			subTitle.styled(font: .systemFont(ofSize: 12, weight: .regular), color: .black).text
		}
	}
}
