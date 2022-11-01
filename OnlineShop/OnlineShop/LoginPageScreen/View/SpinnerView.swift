//
//  SpinnerView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 01.11.2022.
//

import SwiftUI

struct SpinnerView: View {

		@State var animation = false

		var body: some View {
				VStack {

						Circle()
								.trim(from: 0, to: 0.7)
								.stroke(Color.customPurple, lineWidth: 8)
								.frame(width: 75, height: 75)
								.rotationEffect(.degrees(animation ? 360 : 0))
								.padding(50)
				}
				.background(Color.white)
				.cornerRadius(20)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(
						Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all)
				)
				.onAppear {
						withAnimation(.linear(duration: 1)) {
								animation.toggle()
						}
				}
		}
}

struct SpinnerView_Previews: PreviewProvider {
		static var previews: some View {
				SpinnerView()
		}
}
