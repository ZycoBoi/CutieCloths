//
//  ContentView.swift
//  CutieClothsKidsFasion
//
//  Created by sankar on 02/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    var body: some View {
        MainView()
//        selectedView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
