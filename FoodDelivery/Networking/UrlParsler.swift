//
//  UrlParsler.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import Foundation

protocol UrlParslerProtocol {

	func createUrl(host: String, path: String, query: [String: Any]) -> String
}

final class UrlParsler: UrlParslerProtocol {

	func createUrl(host: String, path: String, query: [String: Any]) -> String {
		guard !host.isEmpty && !path.isEmpty else { return ""}
		var requestedQuery = ""
		for (key, value) in query {
			requestedQuery = requestedQuery + "\(key)=\(value)&"
		}
		requestedQuery.removeLast()

		let createdUrl = "\(host)/\(path)?\(requestedQuery)"
		return createdUrl
	}
}
