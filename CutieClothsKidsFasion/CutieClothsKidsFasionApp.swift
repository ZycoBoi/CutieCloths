//
//  CutieClothsKidsFasionApp.swift
//  CutieClothsKidsFasion
//
//  Created by sankar on 02/08/24.
//

import SwiftUI

@main
struct CutieClothsKidsFasionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
