//
//  ViewModel.swift
//  iMensa
//
//  Created by Florian Scholz on 03.05.22.
//

import Foundation
import Combine

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

class MensaDataService {

  static let shared = MensaDataService()

  func fetchData() -> AnyPublisher<[MealData], Error> {

    let url = URL(string: "https://api.mensa.legacymo.de/")!

    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .tryMap { (data, response) -> Data in
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
          throw URLError(URLError.Code.badServerResponse)
        }
        return data
      }
      .decode(type: [MealData].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }

}

class MensaDataViewModel: ObservableObject {

  @Published var mealData: [MealData] = []
  var cancellables = Set<AnyCancellable>()
  let dataService: MensaDataService

  init(dataService: MensaDataService) {
    self.dataService = dataService
    loadMealData()
  }

  private func loadMealData() {
    MensaDataService.shared.fetchData()
      .sink { completion in
        switch completion {
        case .failure(let error):
          print(error.localizedDescription)
          break
        case .finished:
          break
        }
      } receiveValue: { [weak self] data in
        self?.mealData = data
      }
      .store(in: &cancellables)

  }

}
