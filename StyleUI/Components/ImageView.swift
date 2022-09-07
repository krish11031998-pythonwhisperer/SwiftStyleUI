//
//  ImageView.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import SwiftUI

enum ImageLoadError: String, Error {
	case invalidURL = "Invalid Url"
	case unknown = "Unknown Error"
	case imageDownlodFail = "(FAIL) Image was not downloaded"
}

extension UIImage {
	
	static var cache: NSCache<NSString,UIImage> = { .init() }()
}

class ImageDownloader: ObservableObject {
	
	@Published var image: UIImage? = nil
	
	func loadImage(url: String) {
		if let validImage = UIImage.cache.object(forKey: url as NSString) {
			DispatchQueue.main.async {
				self.image = validImage
			}
		} else {
			guard let validURL = URL(string: url) else {
				print("(Error) URL is not valid")
				print(ImageLoadError.invalidURL.rawValue)
				return
			}
			
			URLSession.shared.dataTask(with: validURL) { data, _, err in
				guard let validData = data, let img = UIImage(data: validData) else {
					if let validErr = err {
						print("(ERROR) err : ",validErr)
					}
					print(ImageLoadError.imageDownlodFail.rawValue)
					return
				}
				
				UIImage.cache.setObject(img, forKey: url as NSString)
				DispatchQueue.main.async {
					self.image = img
				}

			}.resume()
		}
	}
	
}

struct ImageView: View {
	
	let url: String
	@StateObject var IMD: ImageDownloader = .init()
	
	init(url: String = "") {
		self.url = url
	}

    var body: some View {
		ZStack(alignment: .center) {
			Color.gray.opacity(0.25)
			if let validImage = IMD.image {
				Image(uiImage: validImage)
					.resizable()
					.scaledToFill()
			}
		}
		.onAppear {
			IMD.loadImage(url: url)
		}
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png")
			.frame(size: .init(width: 200, height: 200))
			.clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
