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
}
