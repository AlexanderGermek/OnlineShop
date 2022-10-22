//
//  Product.swift
//  OnlineShop
//
//  Created by Alexander Germek on 22.10.2022.
//

import Foundation

struct Product: Identifiable, Hashable {
		var id = UUID().uuidString
		var type: ProductType
		var title: String
		var subtitle: String
		var description: String = ""
		var price: String
		var productImage: String = ""
		var quantity: Int = 1
}
