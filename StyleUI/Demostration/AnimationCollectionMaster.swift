//
//  AnimationMaster.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI

struct AnimationCollectionMaster: View {
	let colors : [Color] = [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue]
	
	func headerBuilder(title: String, subTitle: String? = nil) -> AnyView {
		HStack(alignment: .center, spacing: 10) {
			title.text
				.padding(10)
				.borderCard(borderColor: .red, radius: 8, borderWidth: 1)
			Spacer()
			if let validSubTitle = subTitle {
				validSubTitle.text
			}
		}.padding()
		.anyView
	}
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .center, spacing: 10) {
				
				SlideOverCarousel(data:[Color.red, Color.blue, Color.brown, Color.mint]) { color in
					VStack(alignment: .leading, spacing: 15) {
						RoundedButton(model: .testModelLeading)
							.fixedHeight(height: 50)
						"This is a test text , a alternative to the boring Lorem ipsum text"
							.styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black)
							.text
						Spacer()
					}
					.padding()
					.frame(size: .init(width: .totalWidth - 20, height: 200))
					.background((color as? Color) ?? .black)
					.clipContent(radius: 16)
				}
				.containerize(header: headerBuilder(title: "Slide Over Carousel"))

				CascadingCardStack(data: colors, offFactor: .totalWidth.half.half) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 350)
				}
				.containerize(header: headerBuilder(title: "Cascading Card Stack"))
					
				SlideZoomScroll(data: colors, itemSize: .init(width: 200, height: 200)) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 200)
				}.containerize(header: headerBuilder(title: "Slide Zoom Scroll"))
				
				SlideCardView(data: colors, itemSize: .init(width: 200, height: 200), spacing: 0, leading: false) { color,isSelected in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 200)
						.overlay {
							VStack(alignment: .leading) {
								Spacer()
								if isSelected {
									"isSelected".text
										.transition(.move(edge: .bottom))
										.padding(.bottom,10)
								}
							}
							.frame(width: 200, height: 200)
							.scaleEffect(0.85)
						}
				}.containerize(header: headerBuilder(title: "Slide Card View"))
				
				
				SlideZoomScroll(data: colors, itemSize: .init(width: 200, height: 200)) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 200)
				}.containerize(header: headerBuilder(title: "Slide Zoom Scroll"))
			
			}
		}
		.navigationTitle("Animatable Collections")
	}
}
