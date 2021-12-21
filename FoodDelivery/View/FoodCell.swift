//
//  FoodCell.swift
//  FoodDelivery
//
//  Created by Daria Ten on 14.12.2021.
//

import UIKit

final class FoodCell: UITableViewCell {

	static let reuseIdentifier = "FoodCell"

	@IBOutlet weak var foodLabel: UILabel!
	@IBOutlet weak var foodImage: UIImageView!

	func updateFood(food: Food) {
		guard let foodImageUrl = URL(string: food.image) else { return }

		DispatchQueue.global().async {
			if let foodImageData = try? Data(contentsOf: foodImageUrl) {
				DispatchQueue.main.async {
					self.foodImage.image = UIImage(data: foodImageData)
				}
			}
		}
		foodLabel.text = food.title
	}
}
