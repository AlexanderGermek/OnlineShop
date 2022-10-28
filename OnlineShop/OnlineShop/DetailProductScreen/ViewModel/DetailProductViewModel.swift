//
//  DetailProductViewModel.swift
//  OnlineShop
//
//  Created by Alexander Germek on 24.10.2022.
//

import Foundation

final class DetailProductViewModel: ObservableObject {

		@Published var product: Product?
		@Published var isShowDetailProduct = false
		@Published var fromSearch = false
		@Published var likedProducts: [Product] = []
		@Published var cartProducts: [Product] = []

		func getTotalPrice() -> String {
				var total: Int = 0

				cartProducts.forEach { product in
						let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
						let priceOfProduct = product.quantity * price.integerValue
						total += priceOfProduct
				}

				return "$\(total)"
		}
}
