//  sample_macos_appApp.swift
//  sample-macos-app
//  Created by Jake Badoino on 28/11/2026.

import SwiftUI
import CoreData

@main
struct sample_macos_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
