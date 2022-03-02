//
//  AsanaInfoView.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 02.08.2021.
//

import SwiftUI

struct AsanaInfoView: View {
    @State var asana: Asana
    var body: some View {
        ScrollView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Text(asana.name)
                    .font(.largeTitle)
                    .padding(.top,10)
                Text(asana.description)
                    .padding(.all, 10)
                    .multilineTextAlignment(.center)
                Image(asana.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack() {
                    ForEach(asana.chakras, id: \.self) { chakra in
                        Image(chakra)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                Spacer()
            }
        }
        
    }
}

struct AsanaInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AsanaInfoView(asana: Asana(name: "chataranga", image: "yoga-2", description: "gdgd", chakras: ["love"], isChoosed: false))
    }
}
