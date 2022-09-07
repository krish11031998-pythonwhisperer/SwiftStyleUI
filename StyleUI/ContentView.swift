//
//  ContentView.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import SwiftUI

struct ContentView: View {
	let colors : [Color] = [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue]
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVStack(alignment: .leading, spacing: 10) {
				Container(heading: "Slide Over Carousel") {
					SlideOverCarousel(data:[Color.red, Color.blue, Color.brown, Color.mint]) { color in
						RoundedRectangle(cornerRadius: 20)
							.fill((color as? Color) ?? .black)
							.frame(width: .totalWidth - 20, height: 200, alignment: .center)
					}
				}
				
				Container(heading: "Cascading Card Stack") {
					CascadingCardStack(data: colors, offFactor: .totalWidth.half.half) { color in
						RoundedRectangle(cornerRadius: 20)
							.fill((color as? Color) ?? .red)
							.frame(width: 200, height: 350)
					}
				}
				
				Container(heading: "Slide Zoom Scroll") {
					SlideZoomScroll(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue], itemSize: .init(width: 200, height: 200)) { color in
						RoundedRectangle(cornerRadius: 20)
							.fill((color as? Color) ?? .red)
							.frame(width: 200, height: 200)
					}
				}
				
				Container(heading: "Slide Card View") {
					SlideCardView(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue], itemSize: .init(width: 200, height: 200), spacing: 0, leading: false) { color in
						RoundedRectangle(cornerRadius: 20)
							.fill((color as? Color) ?? .red)
							.frame(width: 200, height: 200)
							.preference(key: SizePreferenceKey.self, value: .init(width: 200, height: 200))
					}
				}
				
				Container(heading: "Slide Zoom Scroll") {
					SlideZoomScroll(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue], itemSize: .init(width: 200, height: 200)) { color in
						RoundedRectangle(cornerRadius: 20)
							.fill((color as? Color) ?? .red)
							.frame(width: 200, height: 200)
					}
				}

			}.padding(.horizontal, 10)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
