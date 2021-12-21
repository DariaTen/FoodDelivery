//
//  FoodApiService.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import Foundation

protocol FoodApiServiceProtocol {

	func getFood(requestedFood: String, completion: @escaping (Result<MenuItems, Error>) -> Void)
}

final class FoodApiService: FoodApiServiceProtocol {

	private let networking: NetworkingProtocol
	private let urlParsler: UrlParslerProtocol

	init(networking: NetworkingProtocol,
		 urlParlsler: UrlParslerProtocol) {
		self.networking = networking
		self.urlParsler = urlParlsler
	}

	enum FoodApiServiceError: Error {
		case wrongUrl
	}

	func getFood(requestedFood: String, completion: @escaping (Result<MenuItems, Error>) -> ()) {
		let resultUrl = urlParsler.createUrl(host: "https://api.spoonacular.com",
											  path: "food/menuItems/search",
											  query: ["query": requestedFood,
													  "apiKey": "4e0413e2412f4b3384eedc044ee8ad6e"])
//		let resultUrl = "https://api.spoonacular.com/food/menuItems/search?query=pizza&apiKey=4e0413e2412f4b3384eedc044ee8ad6e"

		guard let url = URL(string: resultUrl) else {
			completion(.failure(FoodApiServiceError.wrongUrl))
			return
		}
		networking.performRequest(url: url, completion: completion)
	}
}

