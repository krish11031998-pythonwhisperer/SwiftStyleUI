//
//  ContentView.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import SwiftUI

struct ContentView: View {
	@State var showAnimation: Bool = false
	@State var imageView: Bool = false
	var animationView: some View {
		AnimationCollectionMaster()
	}
	
	init() {
		
	}
	
	var navBarAppearance: UINavigationBarAppearance {
		let navAppearance = UINavigationBarAppearance()
		navAppearance.backgroundColor = .purple
		navAppearance.shadowColor = .clear
		navAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
		navAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
		return navAppearance
	}
	
    var body: some View {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 20) {
					"Animated Collections".text
						.buttonify {
							asyncMainAnimation {
								self.showAnimation.toggle()
							}
						}
					"Image".text
						.buttonify {
							asyncMainAnimation {
								self.imageView.toggle()
							}
						}
						
				}.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				
				NavLink(isActive: $showAnimation) {
					AnimationCollectionMaster()
						.navigationBarTitleDisplayMode(.inline)
				}
				imageNavLink
			}
			.navigationBarHidden(true)
			.customNavbarAppearance(navbarAppearance: navBarAppearance)
    }
}

extension ContentView {
	var imageNavLink: some View {
		NavLink(isActive: $imageView) {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .center, spacing: 10) {
					Section {
						ImageView(url: "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png")
							.frame(size: .init(width: 100, height: 100))
							.clipContent(radius: 16)
							
					} header: {
						HStack(alignment: .center, spacing: 10) {
							"Rectangle Image".text
							Spacer()
							"Caption".text
						}.padding()
					} footer: {
						Spacer()
							.frame(size: .init(width: .zero, height: 15))
					}

					Section {
						ImageView(url: "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png")
							.frame(size: .init(width: 100, height: 100))
							.clipContent(radius: 50)
					} header: {
						HStack(alignment: .center, spacing: 10) {
							"Circle Image".text
							Spacer()
							"Caption".text
						}
						.padding()
					} footer: {
						Spacer()
							.frame(size: .init(width: .zero, height: 15))
					}

				}
			}
			.navigationTitle("ImageView")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
