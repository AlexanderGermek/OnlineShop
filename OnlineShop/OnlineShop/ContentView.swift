//
//  ContentView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI

struct ContentView: View {
		/// Log status
		@AppStorage("logStatus") var logStatus = false
		var body: some View {
				Group {
						if logStatus {
								MainPage()
						} else {
								OnBoardingPage()
						}
				}
		}
}

struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
				ContentView()
		}
}
