//
//  SlideViewWithAddedAsanas.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 03.08.2021.
//

import SwiftUI

struct SlideViewWithAddedAsanas: View {
    @Binding var asanasList: [Asana]
    var body: some View {
        VStack(alignment: .leading) {
            let choosedAsanas = sortAsanas(list: asanasList)
            if choosedAsanas.count != 0 {
                ScrollView {
                ForEach(choosedAsanas, id: \.self) { asana in
                    HStack {
                        Image(asana.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                        Spacer()
                        Text(asana.name)
                            .foregroundColor(.black)
                            .font(.headline)
                        Spacer()
                        //Image with delete item
                    }
                    .ignoresSafeArea(.all, edges: .all)
                    .padding(.top, 50)
                    .onTapGesture {
                        if let index = asanasList.firstIndex(of: asana) {
                            withAnimation {
                                asanasList[index].isChoosed.toggle()
                            }
                            
                        }
                    }
                }
                }
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.black)
                            .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Clear All")
                            .foregroundColor(.white)
                    }.onTapGesture {
                        withAnimation {
                            clearAllList()
                        }
                        
                    }
                    Spacer()
                }
            } else {
                Spacer()
                HStack {
                    Spacer()
                    Text("Your training list is empty")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.headline)
                        .lineLimit(nil)
                        .padding(.trailing, 20)
                    Spacer()
                }
                
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 255/255, green: 255/255, blue: 255/255))
        .edgesIgnoringSafeArea(.all)
    }
    
    func clearAllList() {
        asanasList = AsanaList().asanas
    }
    
    func sortAsanas(list: [Asana]) -> [Asana] {
        var newList: [Asana] = []
        for asana in list {
            if asana.isChoosed {
                newList.append(asana)
            }
        }
        return newList
    }
}

//struct SlideViewWithAddedAsanas_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideViewWithAddedAsanas()
//    }
//}
