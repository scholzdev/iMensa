//
//  iMensaApp.swift
//  iMensa WatchKit Extension
//
//  Created by Florian Scholz on 04.05.22.
//

import SwiftUI

@main
struct iMensaApp: App {
  @SceneBuilder var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
          .environmentObject(MensaDataViewModel(dataService: MensaDataService.shared))
      }
    }

    WKNotificationScene(controller: NotificationController.self, category: "myCategory")
  }
}
