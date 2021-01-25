//
//  ContentView.swift
//  LilPicker
//
//  Created by Romain Pipon on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        PickerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
