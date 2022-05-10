//
//  ContentView.swift
//  iMensa WatchKit Extension
//
//  Created by Florian Scholz on 04.05.22.
//

import SwiftUI

struct ContentView: View {

  @EnvironmentObject var viewModel: MensaDataViewModel

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
      .navigationTitle("Essensplan")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ContentView()
      }
    }
}
