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
	
	@State var showDiscoveryView: Bool = false
	
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
	
	static var colors: [Color] {
		let blue = Array(repeating: Color.blue, count: 5)
		let red = Array(repeating: Color.red, count: 5)
		let green = Array(repeating: Color.green, count: 5)
		let indigo = Array(repeating: Color.indigo, count: 5)
		
		return (blue + red + green + indigo).shuffled()
	}
	
	static var discoveryModel: DiscoveryViewModel {
		.init(cardSize: .init(width: 250, height: 350), rows: 5, spacing:25)
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
				
				RoundedButton(model: .init(topLeadingText: "Discovery View", bottomLeadingText: "Experience it!", blob: .init(background: .gray.opacity(0.14), padding: 10, cornerRadius: 20))) {
					showDiscoveryView.toggle()
				}.padding()
			
			}
		}
		.navigationTitle("Animatable Collections")
		.fullScreenCover(isPresented: $showDiscoveryView) {
			ZStack(alignment: .center) {
				Color.black
				DiscoveryView(data: Self.colors, model: Self.discoveryModel) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .brown)
						.frame(size: .init(width: 250, height: 350))
				}
			}
			.frame(size: .init(width: .totalWidth, height: .totalHeight))
			.edgesIgnoringSafeArea(.all)
		}
	}
}
