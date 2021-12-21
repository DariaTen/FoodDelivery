//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Daria Ten on 13.12.2021.
//

import UIKit
import DropDown

protocol FoodView: AnyObject {

	func updateFood(_ food: MenuItems)
}

final class ViewController: UIViewController {

	static func storyboardInstance() -> ViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? ViewController
	}

	@IBOutlet weak var dropDownView: UIView!
	@IBOutlet weak var dropDownLabel: UILabel!
	@IBOutlet weak var collectionViewPromo: UICollectionView!
	@IBOutlet weak var collectionViewCategory: UICollectionView!
	@IBOutlet weak var tableView: UITableView!

	private let city = DropDown()
	private var cities: [String] = []
	private var promos: [String] = []
	private var category: [String] = []
	private var currentSelected: Int?

	private var food = [Food]()

	var presenter : FoodPresenter?

	override func viewDidLoad() {
		super.viewDidLoad()

		setupDataSource()
		setUpDDConfiguration()
	}

	// MARK: - Private

	private func setupDataSource() {
		cities = presenter?.getCities() ?? []
		promos = presenter?.getPromos() ?? []
		category = presenter?.getCategories() ?? []
	}

	// MARK: - Drop and Down Methods

	@IBAction func showCityOptions(_ sender: UIButton) {
		city.show()
	}

	private func setUpDDConfiguration() {
		dropDownLabel.text = "Выберите город"
		city.dataSource = cities
		city.anchorView = dropDownView
		city.selectionAction = { [weak self] (index: Int, item: String) in
			self?.dropDownLabel.text = self?.cities[index]
		}
	}
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (collectionView == collectionViewCategory) {
			return category.count
		}
		return promos.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cellPromo = collectionViewPromo.dequeueReusableCell(withReuseIdentifier: PromoCell.reuseIdentifier, for: indexPath) as? PromoCell else { return UICollectionViewCell() }

		cellPromo.promoImage.image = UIImage(named: promos[indexPath.row])
		cellPromo.layer.cornerRadius = 15

		if (collectionView == collectionViewCategory) {
			guard let cellCategory = collectionViewCategory.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }

			cellCategory.caletogyLabel.text = category[indexPath.row]
			cellCategory.caletogyLabel.textColor = currentSelected == indexPath.row ? UIColor.white : UIColor.red
			cellCategory.backgroundColor = currentSelected == indexPath.row ? UIColor.red : UIColor.clear
			cellCategory.layer.cornerRadius = 15
			cellCategory.layer.borderColor = UIColor.red.cgColor
			cellCategory.layer.borderWidth = 2

			return cellCategory
		}
		return cellPromo
	}
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if (collectionView == collectionViewCategory) {
			currentSelected = indexPath.row
			collectionViewCategory.reloadData()

			presenter?.loadFood(for: category[indexPath.row])
		}
	}
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		food.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseIdentifier, for: indexPath) as? FoodCell else { return UITableViewCell() }
		cell.updateFood(food: food[indexPath.row])
		cell.foodImage.layer.cornerRadius = 15

		return cell
	}
}

// MARK: - FoodView

extension ViewController: FoodView {

	func updateFood(_ food: MenuItems) {
		self.food = food.menuItems
		tableView.reloadData()
	}
}
