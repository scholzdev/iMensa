//
//  iMensaApp.swift
//  Shared
//
//  Created by Florian Scholz on 03.05.22.
//

import SwiftUI
import UserNotifications

@main
struct iMensaApp: App {
  @AppStorage("enableNotifications") var enableNotifications = false
  @AppStorage("openingReminder") var openingReminder = false
  @AppStorage("closingReminder") var closingReminder = false

  func fireNotifications() {

    if !enableNotifications {
      return
    }

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.weekday = Calendar.current.component(.weekday, from: Date())

    if openingReminder {
      dateComponents.hour = 11
    } else if closingReminder {
      dateComponents.hour = 14
    }

    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

    let content = UNMutableNotificationContent()
    content.title = "iMensa"

    if openingReminder {
      content.body = "Die Mensa öffnet in 30 Minuten"
    } else if closingReminder {
      content.body = "Die Mensa schließt in 30 Minuten"
    }

    let uuid = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }

  }

  var body: some Scene {
    WindowGroup {
      ContentView()
      .onAppear {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
          if success {
            enableNotifications = true
          } else if let error = error {
            print(error.localizedDescription)
          }
        })
        fireNotifications()
      }
      .environmentObject(MensaDataViewModel(dataService: MensaDataService.shared))
    }
  }
}
