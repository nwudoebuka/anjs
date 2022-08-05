//
//  AndJsonSwiftUITestApp.swift
//  AndJsonSwiftUITest
//
//  Created by Anthony Nwudo on 03/08/2022.
//

import SwiftUI

@main
struct AndJsonSwiftUITestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
