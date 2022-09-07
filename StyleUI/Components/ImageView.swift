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
	
	static var testImage: String { "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png" }
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
	
	let url: String?
	let img: UIImage?
	@StateObject var IMD: ImageDownloader = .init()
	
	init(url: String? = nil, img: UIImage? = nil) {
		self.url = url
		self.img = img
	}
	
	private var image: UIImage? {
		IMD.image ?? img
	}
	
	private func onAppear() {
		guard let validURL = url else { return }
		IMD.loadImage(url: validURL)
	}

    var body: some View {
		ZStack(alignment: .center) {
			Color.gray.opacity(0.25)
			if let validImage = image {
				Image(uiImage: validImage)
					.resizable()
					.scaledToFill()
			}
		}
		.onAppear(perform: onAppear)
    }
}

extension ImageView {
	
	func framed(size: CGSize, cornerRadius: CGFloat = 8, alignment: Alignment = .center) -> some View {
		self.frame(size: size, alignment: alignment)
			.clipContent(radius: cornerRadius)
	}
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "")
			.frame(size: .init(width: 200, height: 200))
			.clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
