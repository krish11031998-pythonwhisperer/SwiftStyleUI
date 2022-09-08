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
				RoundedButton(model: .testModelLeading)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Leading Image").padding().anyView)
				
				RoundedButton(model: .testModelTrailing)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Trailing Image").padding().anyView)
					
				RoundedButton(model: .testModel)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/o Image").padding().anyView)
				
				RoundedButton(model: .testModelWithBlob)
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Blob").padding().anyView)
			}
		}
		.navigationTitle("Rounded Button")
		.navigationBarTitleDisplayMode(.inline)
    }
}



struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonComponents()
    }
}
