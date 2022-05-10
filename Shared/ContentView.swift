//
//  ContentView.swift
//  Shared
//
//  Created by Florian Scholz on 03.05.22.
//

import SwiftUI
import Combine
import UserNotifications

struct ContentView: View {

  @EnvironmentObject private var viewModel: MensaDataViewModel
  @State private var toggleSettings = false

  var body: some View {
    NavigationView {
      List(viewModel.mealData, id: \.self) { mealData in
        NavigationLink {
          MealDataView(mealData: mealData)
        } label: {
          Label {
            Text("\(mealData.day) (\(mealData.date))")
          } icon: {
            Image(systemName: "calendar")
          }

        }
      }
      .toolbar(content: {
        Button {
          toggleSettings.toggle()
        } label: {
          Image(systemName: "gear")
        }

      })
      .navigationTitle("Essensplan")
      .sheet(isPresented: $toggleSettings) {
        NavigationView {
          SettingsView()
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
