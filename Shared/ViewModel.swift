//
//  ViewModel.swift
//  iMensa
//
//  Created by Florian Scholz on 03.05.22.
//

import Foundation

struct Costs: Hashable, Codable {
  let a: String
  let b: String
}

struct Meal: Hashable, Codable {
  let name: String
  let costs: Costs
}

struct Food: Hashable, Codable {
  let type: String
  let meal: [Meal]
}

struct MealData: Hashable, Codable {
  let day: String
  let date: String
  let food: [Food]
}

class ViewModel: ObservableObject {

  @Published var mealData: [MealData] = []

  init() {
    fetch()
  }

  func fetch() {
    guard let url = URL(string: "https://api.mensa.legacymo.de/") else {
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard let data = data, error == nil else {
        return
      }

      do {
        let mealData = try JSONDecoder().decode([MealData].self, from: data)

        DispatchQueue.main.async {
          self?.mealData = mealData
        }
      } catch {
        print(error)
      }
    }

    task.resume()

  }

}
