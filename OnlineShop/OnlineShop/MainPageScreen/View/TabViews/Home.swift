//
//  Home.swift
//  OnlineShop
//
//  Created by Alexander Germek on 22.10.2022.
//

import SwiftUI

struct Home: View {
		// MARK: Matched Geometry Effect var's
		@Namespace var animation
		private var productLineAnimationName = "productLineAnimationName"

		/// viewModel
		@StateObject var viewModel: HomeViewModel = HomeViewModel()

		var body: some View {
				ScrollView(.vertical, showsIndicators: false) {
						VStack(spacing: 15) {

								/// Search Bar
								HStack(spacing: 15) {
										Image(systemName: "magnifyingglass")
												.font(.title2)
												.foregroundColor(.gray)

										TextField("Search", text: .constant(""))
												.disabled(true)
								}
								.padding(.vertical, 12)
								.padding(.horizontal)
								.background(
										Capsule()
												.strokeBorder(.gray, lineWidth: 0.8)
								)
								.frame(width: getScreenBounds().width / 1.6)
								.padding(.horizontal, 25)

								/// Main  Home Text
								Text("Order online\ncollect in store")
										.font(.custom(Font.raleway, size: 28).bold())
										.frame(maxWidth: .infinity, alignment: .leading)
										.padding(.top)
										.padding(.horizontal, 25)

								/// Products tabview - подписи разделов
								ScrollViewReader { proxy in
										ScrollView(.horizontal, showsIndicators: false) {
												//										ScrollViewReader { proxy in

												HStack(spacing: 18) {
														ForEach(ProductType.allCases, id: \.self) { type in
																productTypeView(for: type)
														}
												}
												.padding(.horizontal, 25)
												//										}
										}
										.padding(.top, 28)
//										.onChange(of: viewModel.productType) { _ in
//												viewModel.filterProductByType()
////												proxy.scrollTo(0)
//										}
								}

								/// Product Page - карточки продуктов
								ScrollView(.horizontal, showsIndicators: false) {
										HStack(spacing: 25) {
												ForEach(viewModel.filteredProducts) { product in
														productCardView(for: product)
												}
										}
										.padding(.horizontal, 25)
										.padding(.bottom)
										.padding(.top, 80)
								}
								.padding(.top, 30)

								/// See More Button ...
								getSeeMoreButton()
						}
						.padding(.vertical)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(Color.homeBackground)
				.onChange(of: viewModel.productType) { _ in
						viewModel.filterProductByType()
				}
				.sheet(isPresented: $viewModel.isShowMoreProductsOnType) {

				} content: { 
						MoreProductsView()
				}

		}

		// MARK: Private functions
		private func productTypeView(for type: ProductType) -> some View {
				Button {
						withAnimation {
								viewModel.productType = type
						}
				} label: {
						Text(type.rawValue)
								.font(.custom(Font.raleway, size: 15))
								.fontWeight(.semibold)
								.foregroundColor(viewModel.productType == type ? Color.customPurple : .gray)
								.padding(.bottom, 10)
								/// Purple Line
								.overlay(
										/// Matched Geometry Effect - перетекающая анимация между элементами
										ZStack {
												if viewModel.productType == type {
														Capsule()
																.fill(Color.customPurple)
																.matchedGeometryEffect(id: productLineAnimationName, in: animation)
																.frame(height: 2)
												} else {
														Capsule()
																.fill(.clear)
																.frame(height: 2)
												}
										}
										.padding(.horizontal, -5)
										, alignment: .bottom
								)
				}
		}

		private func productCardView(for product: Product) -> some View {
				let imageSize = getScreenBounds().width / 2.5

				return VStack(spacing: 10) {

						Image(product.productImage)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: imageSize, height: imageSize)

						/// Moving image to top to look like its fixed at half top
								.offset(y: -80)
								.padding(.bottom, -80)

						Text(product.title)
								.font(.custom(Font.raleway, size: 18))
								.fontWeight(.semibold)
								.padding(.top)

						Text(product.subtitle)
								.font(.custom(Font.raleway, size: 14))
								.foregroundColor(.gray)

						Text(product.price)
								.font(.custom(Font.raleway, size: 16))
								.fontWeight(.bold)
								.foregroundColor(Color.customPurple)
								.padding(.top, 5)
				}
				.padding(.horizontal, 20)
				.padding(.bottom, 22)
				.background(
						Color.white.cornerRadius(25)
				)
		}

		private func getSeeMoreButton() -> some View {
				Button {
						viewModel.isShowMoreProductsOnType.toggle()
				} label: {
						Label {
								Image(systemName: "arrow.right")
						} icon: {
								Text("see more")
						}
						.font(.custom(Font.raleway, size: 15).bold())
						.foregroundColor(Color.customPurple)
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
				.padding(.trailing)
				.padding(.top, 10)
		}
}

struct Home_Previews: PreviewProvider {
		static var previews: some View {
				Home()
		}
}
