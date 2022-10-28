//
//  DetailProductView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 24.10.2022.
//

import SwiftUI

struct DetailProductView: View {
//		var product: Product
		// MARK: Properties
		var animation: Namespace.ID // matched geometry effect

		@EnvironmentObject var detailViewModel: DetailProductViewModel
		@EnvironmentObject var homeViewModel: HomeViewModel

		var body: some View {
				VStack {
						/// Title Bar and Product Image
						VStack {

								/// Title Bar
								HStack {
										/// Close detail view
										Button {
												withAnimation(.easeInOut) {
														detailViewModel.isShowDetailProduct = false
												}
										} label: {
												Image(systemName: "arrow.left")
														.font(.title2)
														.foregroundColor(.black.opacity(0.7))
										}

										Spacer()

										/// Liked
										Button {
												addToLiked()
										} label: {
												Image("Liked")
														.renderingMode(.template)
														.resizable()
														.aspectRatio(contentMode: .fit)
														.frame(width: 22, height: 22)
														.foregroundColor(isLiked() ? .red : .black.opacity(0.7))
										}
								}
								.padding()

								/// Product Image
								Image(detailViewModel.product?.productImage ?? "")
										.resizable()
										.aspectRatio(contentMode: .fit)
										.matchedGeometryEffect(id: "\(detailViewModel.product?.id ?? "")\(detailViewModel.fromSearch ? "SEARCH" : "IMAGE")",
																					 in: animation)
										.padding(.horizontal)
										.offset(y: -12)
										.frame(maxHeight: .infinity)

						}
						.frame(height: getScreenBounds().height / 2.7)
						.zIndex(1)

						/// Product Details
						ScrollView(.vertical, showsIndicators: false) {
								ProductDetailsView()
						}
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(
								Color.white
										.clipShape(CustomCornerShape(corners: [.topLeft, .topRight], radius: 25))
										.ignoresSafeArea()
						)
						.zIndex(0)
				}
				.animation(.easeInOut, value: detailViewModel.likedProducts)
				.animation(.easeInOut, value: detailViewModel.cartProducts)
				.background(Color.homeBackground.ignoresSafeArea())
		}

		// MARK: some Views
		private func ProductDetailsView() -> some View {
				VStack(alignment: .leading, spacing: 15) {
						/// Descriptions
						Text(detailViewModel.product?.title ?? "")
								.font(.custom(Font.raleway, size: 20).bold())

						Text(detailViewModel.product?.subtitle ?? "")
								.font(.custom(Font.raleway, size: 18))
								.foregroundColor(.gray)

						Text("Get Apple TV+ free for a year")
								.font(.custom(Font.raleway, size: 16).bold())
								.padding(.top)

						Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, $4.99/month after free trial.")
								.font(.custom(Font.raleway, size: 15))
								.foregroundColor(.gray)

						/// Full description
						Button {

						} label: {
								Label {
										Image(systemName: "arrow.right")
								} icon: {
										Text("Full description")
								}
								.font(.custom(Font.raleway, size: 15).bold())
								.foregroundColor(Color.customPurple)
						}

						/// Price
						HStack {
								Text("Total")
										.font(.custom(Font.raleway, size: 17))

								Spacer()

								Text("\(detailViewModel.product?.price ?? "")")
										.font(.custom(Font.raleway, size: 20).bold())
										.foregroundColor(Color.customPurple)
						}
						.padding(.vertical, 20)

						/// Add button
						Button {
								addToCart()
						} label: {
								Text("\(isAddedToCart() ? "added" : "add") to basket")
										.font(.custom(Font.raleway, size: 20).bold())
										.foregroundColor(.white)
										.padding(.vertical, 20)
										.frame(maxWidth: .infinity)
										.background(
												(isAddedToCart() ? .red : Color.customPurple)
														.cornerRadius(15)
										)
										.shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
						}

				}
				.padding([.horizontal, .bottom], 20)
				.padding(.top, 25)
				.frame(maxWidth: .infinity, alignment: .leading)
		}

		// MARK: Private
		private func addToLiked() {
				guard let detailProduct = detailViewModel.product else { return }

				if let index = detailViewModel.likedProducts.firstIndex(where: { product in
						return detailProduct.id == product.id
				}) {
						detailViewModel.likedProducts.remove(at: index)
				} else {
						detailViewModel.likedProducts.append(detailProduct)
				}
		}

		private func addToCart() {
				guard let detailProduct = detailViewModel.product else { return }

				if let index = detailViewModel.cartProducts.firstIndex(where: { product in
						return detailProduct.id == product.id
				}) {
						detailViewModel.cartProducts.remove(at: index)
				} else {
						detailViewModel.cartProducts.append(detailProduct)
				}
		}

		private func isLiked() -> Bool {
				guard let detailProduct = detailViewModel.product else { return false}
				return detailViewModel.likedProducts.contains(detailProduct)
		}

		private func isAddedToCart() -> Bool {
				guard let detailProduct = detailViewModel.product else { return false}
				return detailViewModel.cartProducts.contains(detailProduct)
		}

}

//struct DetailProductView_Previews: PreviewProvider {
//		static var previews: some View {
//				let animation: Namespace.ID
//				let object = DetailProductdetailViewModel()
//				object.product = HomedetailViewModel().products[0]
//				return DetailProductView()
//						.environmentObject(object)
//		}
//}
