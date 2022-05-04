//
//  SettingsView().swift
//  iMensa
//
//  Created by Florian Scholz on 04.05.22.
//

import SwiftUI

struct SettingsView: View {

  @AppStorage("enableNotifications") var enableNotifications = false
  @AppStorage("openingReminder") var openingReminder = false
  @AppStorage("closingReminder") var closingReminder = false

  var body: some View {
    Form {
      Section {
        Toggle("Erlauben", isOn: $enableNotifications)
        if enableNotifications {
          Toggle("30 Minuten vor Öffnung", isOn: $openingReminder)
          Toggle("30 Minuten vor Schließung", isOn: $closingReminder)
        }
      } header: {
        Text("Benachrichtigungen")
      }
    }
    .navigationTitle(Text("Einstellungen"))
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
