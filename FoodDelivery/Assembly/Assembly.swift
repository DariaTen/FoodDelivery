//
//  Assembly.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import UIKit

final class Assembly {

	static func createVC() -> UIViewController? {
		
		let urParsler = UrlParsler()
		let networking = Networking()
		let service = FoodApiService(networking: networking, urlParlsler: urParsler)
		let presenter = FoodPresenter(apiService: service)
		let vc = ViewController.storyboardInstance()
		vc?.presenter = presenter
		presenter.delegate = vc
		
		return vc
	}
}
