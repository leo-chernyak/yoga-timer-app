//
//  ContentView.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 28.07.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AsanasCollectionView( asanasList: AsanaList())
        
        
//        Questions()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
