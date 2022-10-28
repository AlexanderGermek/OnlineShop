//
//  Cart.swift
//  OnlineShop
//
//  Created by Alexander Germek on 27.10.2022.
//

import SwiftUI

struct Cart: View {
		@EnvironmentObject var detailViewModel: DetailProductViewModel

		@State var showDeleteOption = false

		var body: some View {
				NavigationView {
						VStack {
								ScrollView(.vertical, showsIndicators: false) {

										VStack {

												HStack {
														Text("Basket")
																.font(.custom(Font.raleway, size: 28).bold())

														Spacer()

														Button {
																withAnimation {
																		showDeleteOption.toggle()
																}
														} label: {
																Image("Delete")
																		.resizable()
																		.aspectRatio(contentMode: .fit)
																		.frame(width: 25, height: 25)
														}
														.opacity(detailViewModel.cartProducts.isEmpty ? 0 : 1)
												}

												if detailViewModel.cartProducts.isEmpty {
														NoLikedProductsView()
												} else {
														LikedProductsView()
												}
										}
										.padding()
								}

								if !detailViewModel.cartProducts.isEmpty {
										Group {

												HStack {

														Text("Total")
																.font(.custom(Font.raleway, size: 14))
																.fontWeight(.semibold)

														Spacer()

														Text(detailViewModel.getTotalPrice())
																.font(.custom(Font.raleway, size: 18).bold())
																.foregroundColor(Color.customPurple)
												}

												Button {

												} label: {

														Text("Checkout")
																.font(.custom(Font.raleway, size: 18).bold())
																.foregroundColor(.white)
																.padding(.vertical, 18)
																.frame(maxWidth: .infinity)
																.background(Color.customPurple)
																.cornerRadius(15)
																.shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
												}
												.padding(.vertical)
										}
										.padding(.horizontal, 25)
								}
						}
						.toolbar(.hidden, for: .navigationBar)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(Color.homeBackground.ignoresSafeArea())
				}
		}

		// MARK: some Views
		private func NoLikedProductsView() -> some View {
				Group {
						Image("NoBasket")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.padding()
								.padding(.top, 35)

						Text("No Items added")
								.font(.custom(Font.raleway, size: 25))
								.fontWeight(.semibold)

						Text("Hit the plus button to save into basket.")
								.font(.custom(Font.raleway, size: 18))
								.padding(.horizontal)
								.padding(.top, 10)
								.multilineTextAlignment(.center)
				}
		}

		private func LikedProductsView() -> some View {
				VStack(spacing: 15) {
						ForEach($detailViewModel.cartProducts) { $product in

								HStack(spacing: 0) {

										if showDeleteOption {

												Button {
														delete(product: product)
												} label: {
														Image(systemName: "minus.circle.fill")
																.font(.title2)
																.foregroundColor(.red)
												}
												.padding(.trailing)
										}

										CardView(product: $product)
								}
						}
				}
				.padding(.top, 25)
				.padding(.horizontal)
		}

		// MARK: Private additional func's
		private func delete(product: Product) {
				if let index = detailViewModel.cartProducts.firstIndex(of: product) {
						let _ = withAnimation {
								detailViewModel.cartProducts.remove(at: index)
						}
				}
		}
}

struct Cart_Previews: PreviewProvider {
		static var previews: some View {
				Cart()
		}
}

struct CardView: View {

		@Binding var product: Product

		var body: some View {
				HStack(spacing: 15) {
						Image(product.productImage)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 100, height: 100)

						VStack(alignment: .leading, spacing: 8) {
								Text(product.title)
										.font(.custom(Font.raleway, size: 18).bold())
										.lineLimit(1)

								Text(product.subtitle)
										.font(.custom(Font.raleway, size: 17))
										.fontWeight(.semibold)
										.foregroundColor(Color.customPurple)

								Text("Type: \(product.type.rawValue)")
										.font(.custom(Font.raleway, size: 13))
										.foregroundColor(.gray)

								HStack {

										Text("Quantity")
												.font(.custom(Font.raleway, size: 14))
												.foregroundColor(.gray)

										Button {
												product.quantity = (product.quantity > 0 ? (product.quantity-1) : 0)
										} label: {
												Image(systemName: "minus")
														.font(.caption)
														.foregroundColor(.white)
														.frame(width: 20, height: 20)
														.background(Color.quantityColor)
														.cornerRadius(4)
										}

										Text("\(product.quantity)")
												.font(.custom(Font.raleway, size: 14))
												.fontWeight(.semibold)
												.foregroundColor(.black)

										Button {
												product.quantity += 1
										} label: {
												Image(systemName: "plus")
														.font(.caption)
														.foregroundColor(.white)
														.frame(width: 20, height: 20)
														.background(Color.quantityColor)
														.cornerRadius(4)
										}
								}
						}
				}
				.padding(.horizontal, 10)
				.padding(.vertical, 10)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.white.cornerRadius(10))
		}
}
