//
//  Profile.swift
//  OnlineShop
//
//  Created by Alexander Germek on 24.10.2022.
//

import SwiftUI
import FirebaseAuth

struct Profile: View {
		private var profileLinks = ["Edit Profile",
																"Shopping address",
																"Order history",
																"Cards",
																"Notifications"]

		@AppStorage("logStatus") var logStatus = false

		@EnvironmentObject var detailViewModel: DetailProductViewModel

		var body: some View {
				NavigationView {
						ScrollView(.vertical, showsIndicators: false) {
								VStack {

										HStack {

												/// My profile
												Text("My Profile")
														.font(.custom(Font.raleway, size: 28).bold())
														.frame(maxWidth: .infinity, alignment: .leading)

												Spacer()

												Button {
														
														do {
																try? Auth.auth().signOut()
														}

														withAnimation(.easeInOut) {
																logStatus = false
														}

												} label: {
														Text("Log Out")
																.font(.custom(Font.raleway, size: 14).bold())
																.foregroundColor(.red)
												}
										}

										VStack(spacing: 15) {
												/// Image
												Image("Profile_Image")
														.resizable()
														.aspectRatio(contentMode: .fill)
														.frame(width: 80, height: 80)
														.clipShape(Circle())
														.offset(y: -30)
														.padding(.bottom, -30)

												Text("Rosina Doe")
														.font(.custom(Font.raleway, size: 16))
														.fontWeight(.semibold)

												/// Adress
												HStack(alignment: .top, spacing: 10) {
														Image(systemName: "location.north.circle.fill")
																.foregroundColor(.gray)
																.rotationEffect(.degrees(180))

														Text("Address: 43 OXford Road\nM13 4GR\nManchester, UK")
																.font(.custom(Font.raleway, size: 15))
												}
												.frame(maxWidth: .infinity, alignment: .leading)
										}
										.padding([.horizontal, .bottom])
										.background(
												Color.white.cornerRadius(12)
										)
										.padding()
										.padding(.top, 40)

										/// Navigation Links
										ForEach(profileLinks, id: \.self) { link in
												CustomNavigationLink(title: link) {
														Text("")
																.navigationTitle(link)
																.frame(maxWidth: .infinity, maxHeight: .infinity)
																.background(Color.homeBackground.ignoresSafeArea())
												}
										}
								}
								.padding(.horizontal, 22)
								.padding(.vertical, 20)
						}
						.toolbar(.hidden, for: .navigationBar)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(
								Color.homeBackground.ignoresSafeArea()
						)
				}
		}

		// MARK: some Views
		private func CustomNavigationLink<Detail: View>(title: String,
																										content: @escaping () -> Detail) -> some View {

				NavigationLink {
						content()
				} label: {
						HStack {

								Text(title)
										.font(.custom(Font.raleway, size: 17))
										.fontWeight(.semibold)

								Spacer()

								Image(systemName: "chevron.right")
						}
						.foregroundColor(.black)
						.padding()
						.background(
								Color.white.cornerRadius(12)
						)
						.padding(.horizontal)
						.padding(.top, 10)
				}

		}
}

struct Profile_Previews: PreviewProvider {
		static var previews: some View {
				Profile()
		}
}
