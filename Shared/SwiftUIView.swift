//
//  SwiftUIView.swift
//  iMensa
//
//  Created by Florian Scholz on 03.05.22.
//

import SwiftUI

struct MealDataView: View {

  let mealData: MealData

  var body: some View {

    List(mealData.food, id: \.self) { food in
      if food.meal.count != 0 {
          Section {
            Text(food.meal.first?.name ?? "Nichts")
            if food.meal.first!.costs.a.isEmpty || food.meal.first!.costs.b.isEmpty {
              Text("Preis: Je nach Gewicht")
            } else {
              Text("Preis: \(food.meal.first?.costs.a ?? "Nichts")")
            }
          } header: {
            Text(food.type).bold()
          }
      }

    }
    .navigationTitle("\(mealData.day)")

  }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
      let data = MealData(day: "Heute", date: "12.12.12", food: [Food(type: "Ausgabe 1", meal: [Meal(name: "Lasagne", costs: Costs(a: "1.99", b: "2.99"))])])
      return MealDataView(mealData: data)
    }
}
