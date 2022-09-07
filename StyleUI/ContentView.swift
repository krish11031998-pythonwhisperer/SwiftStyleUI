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
	@State var roundedButton: Bool = false
	
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
					HeaderSubHeadView(title: "Animated Collections", subTitle: "Here you can see all the animatable fancy collections")
					.buttonify {
							self.showAnimation.toggle()
						}
					HeaderSubHeadView(title: "Image", subTitle: "Every thing you can do with an image")
						.buttonify {
							self.imageView.toggle()
						}
					HeaderSubHeadView(title: "Rounded Button", subTitle: "Custom Rounded Button with custom Config")
						.buttonify {
							self.roundedButton.toggle()
						}
						
				}.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				
				
				animatedCollectionsLink
				imageNavLink
				roundedButtonLink
				
			}
			.navigationBarHidden(true)
			.customNavbarAppearance(navbarAppearance: navBarAppearance)
    }
}

extension ContentView {
	
	var animatedCollectionsLink: some View {
		NavLink(isActive: $showAnimation) {
			AnimationCollectionMaster()
		}
	}
	
	var imageNavLink: some View {
		NavLink(isActive: $imageView) {
			ImageComponents()
		}
	}
	
	var roundedButtonLink: some View {
		NavLink(isActive: $roundedButton) {
			RoundedButtonComponents()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
