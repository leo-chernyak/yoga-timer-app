//
//  AsanaRow.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 01.08.2021.
//

import SwiftUI

struct AsanaRow: View {
    @State private var showPopUp: Bool = false
    @Binding var asana: Asana
    var body: some View {
        HStack {
            Image(asana.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 70, alignment: .center)
            Spacer()
            Text(asana.name)
            Spacer()
            Image("info")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
                .onTapGesture {
                    showPopUp.toggle()
                }
                .sheet(isPresented: $showPopUp, content: {
                    AsanaInfoView(asana: asana)
                })
        }
//        .background(asana.isChoosed ? Color.gray : Color.white)
        .opacity(asana.isChoosed ? 0.3 : 1.0)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                asana.isChoosed.toggle()
                print(asana.id,asana.name)
            }
            
        }
    }
}

//struct AsanaRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AsanaRow()
//    }
//}
