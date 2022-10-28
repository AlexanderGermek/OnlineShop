//
//  MainPage.swift
//  OnlineShop
//
//  Created by Alexander Germek on 22.10.2022.
//

import SwiftUI

struct MainPage: View {
		@State private var currentTab: TabCase = .home

		@StateObject var detailViewModel = DetailProductViewModel()
		@Namespace var animation

		/// Hidden tabbar
		init() {
				UITabBar.appearance().isHidden = true
		}

		var body: some View {

				VStack(spacing: 0) {
						/// Tab View
						TabView(selection: $currentTab) {
										ForEach(TabCase.allCases, id: \.self) { tabCase in

												switch tabCase {
												case .home:
														Home(animation: animation)
																.environmentObject(detailViewModel)
																.tag(tabCase)
												case .profile:
														Profile()
																.tag(tabCase)
												case .liked:
														Liked()
																.environmentObject(detailViewModel)
																.tag(tabCase)
												case .cart:
														Cart()
																.environmentObject(detailViewModel)
																.tag(tabCase)
												}
										}
						}

						/// Tab Bar
						HStack(spacing: 0) {
								ForEach(TabCase.allCases, id: \.self) { tabCase in
										Button {
												currentTab = tabCase
										} label: {
												Image(tabCase.rawValue)
														.resizable()
														.renderingMode(.template)
														.aspectRatio(contentMode: .fit)
														.frame(width: 22, height: 22)
														.background(
																Color.customPurple
																		.opacity(0.1)
																		.cornerRadius(5)
																		.blur(radius: 5)
																		.padding(-7)
																		.opacity(currentTab == tabCase ? 1 : 0)
														)
														.frame(maxWidth: .infinity)
														.foregroundColor(getTabBarColor(tabCase))
										}
								}
						}
						.padding([.horizontal, .top])
						.padding(.bottom, 5)
				}
				.background(Color.homeBackground.ignoresSafeArea())
				.overlay(
						ZStack {
								if detailViewModel.isShowDetailProduct {
										DetailProductView(animation: animation)
												.environmentObject(detailViewModel)
												.transition(.asymmetric(insertion: .move(edge: .trailing),
																								removal: .opacity))
								}
						}
				)
		}

		// MARK: Private func's
		private func getTabBarColor(_ tab: TabCase) -> Color {
				currentTab == tab ? Color.customPurple : .black.opacity(0.3)
		}
}

struct MainPage_Previews: PreviewProvider {
		static var previews: some View {
				MainPage()
		}
}


private enum TabCase: String, CaseIterable {
		case home = "Home"
		case liked = "Liked"
		case profile = "Profile"
		case cart = "Cart"
}
