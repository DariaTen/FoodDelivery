//
//  Food.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import Foundation

struct MenuItems: Decodable {

	let menuItems : [Food]
}

struct Food: Decodable {

	let title: String
	let image : String
}
