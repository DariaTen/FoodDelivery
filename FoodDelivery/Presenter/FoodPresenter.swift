//
//  FoodPresenter.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import Foundation

protocol FoodPresenterProtocol {

	func getCities() -> [String]

	func getPromos() -> [String]

	func getCategories() -> [String]

	func loadFood(for foodRequest: String)
}

final class FoodPresenter: FoodPresenterProtocol {

	weak var delegate: FoodView?
	
	private var food: Food?
	private let cities = ["Москва", "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Казань"]
	private let promos = ["promo", "promo1", "promo2", "promo3", "promo4" ]
	private let category = ["Пицца", "Бургеры", "Суши", "Салаты", "Десерты"]
	private let categoryMap = [
		"Пицца": "pizza",
		"Бургеры": "burger",
		"Суши": "sushi",
		"Салаты": "salad",
		"Десерты": "dessert"
	]
	
	private let apiService: FoodApiServiceProtocol

	init(apiService: FoodApiServiceProtocol) {
		self.apiService = apiService
	}

	func getCities() -> [String] {
		return cities
	}

	func getPromos() -> [String] {
		return promos
	}

	func getCategories() -> [String] {
		return category
	}

	func loadFood(for foodRequest: String) {
		guard let mappedCategory = categoryMap[foodRequest] else { return }
		apiService.getFood(requestedFood: mappedCategory) { result in
			DispatchQueue.main.async {
				switch result {
				case .success(let successResult):
					self.delegate?.updateFood(successResult)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
