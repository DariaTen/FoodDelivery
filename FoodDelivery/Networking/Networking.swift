//
//  Networking.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import Foundation

protocol NetworkingProtocol {

	func performRequest<Response: Decodable>(url: URL,
											 completion: @escaping (Result<Response, Error>) -> Void)
}

final class Networking: NetworkingProtocol {

	enum NetworkingError: Error {
		case emptyData
	}
	
	func performRequest<Response: Decodable>(url: URL,
											 completion: @escaping (Result<Response, Error>) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data,
				  error == nil
			else {
				let responseError = error ?? NetworkingError.emptyData
				completion(.failure(responseError))
				return
			}
			do {
				let response = try JSONDecoder().decode(Response.self, from: data)
				completion(.success(response))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
}
