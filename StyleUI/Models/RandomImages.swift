//
//  RandomImages.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 09/09/2022.
//

import Foundation
import SwiftUI

//MARK: - RandomImage

struct RandomImage: Codable {
	let id: String
	let author: String
	let width: Double
	let height: Double
	let url: String
	let download_url: String
}

extension RandomImage {
	
	func optimizedImage(size: CGSize) -> String {
		RandomImagesEndpoint.id(id: id, width: Int(size.width), height: Int(size.height)).url
	}
}

//MARK: - Random Images Endpoint

enum RandomImagesEndpoint {
	case list(page: Int, limit: Int)
	case id(id: String, width: Int, height: Int)
}

extension RandomImagesEndpoint: EndPoint {
	var scheme: String {
		"https"
	}
	
	
	var baseURL: String {
		"picsum.photos"
	}
	
	var method: String {
		switch self {
		case .list(_, _), .id(_, _, _):
			return "GET"
		}
		
	}
	
	var queryItem: [URLQueryItem] {
		switch self {
		case .list(let page, let limit):
			return [
				.init(name: "page", value: "\(page)"),
				.init(name: "limit", value: "\(limit)")
			]
		default:
			return []
		}
	}
	
	var path: String {
		switch self {
		case .list(_,  _):
			return "/v2/list"
		case .id(let id,let width, let height):
			return "/id/\(id)/\(width)/\(height)"
		}
		
	}
	
	var url: String {
		var uC = URLComponents()
		uC.scheme = scheme
		uC.host = baseURL
		uC.path = path
		uC.queryItems = queryItem
		
		return uC.url?.absoluteString ?? ""
	}
	
	
	func execute<T>(completion:@escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
		NetworkRequest.shared.loadData(urlStr: url, completion: completion)
	}
}

//MARK: - RandomImageDownload

class RandomImages: ObservableObject {
	
	
	
}
