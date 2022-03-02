//
//  AsanasCollectionView.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 30.07.2021.
//

import SwiftUI

struct AsanasCollectionView: View {
    @State private var isPresented = false
    @State var showAddedAsanasView = false
    var size = UIScreen.main.bounds.width/3 - 20
    @ObservedObject var asanasList: AsanaList
    var choosedAsanasAmount: Int {
        get {
            var counter = 0
            for i in asanasList.asanas {
                if i.isChoosed {
                    counter += 1
                }
            }
            return counter
        }
    }
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
//                    self.showAddedAsanasView.toggle()
                    withAnimation {

                        self.showAddedAsanasView.toggle()

                    }
                }
            }
        
        
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                VStack() {
                    HStack() {
                        ZStack {
                            Image("yoga-mat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: .center)
                                .onTapGesture {
                                    print("Show added Assanas")
                                    withAnimation { showAddedAsanasView.toggle()
                                    }
                                    
                                }
                            Text("\(choosedAsanasAmount)")
                                .foregroundColor(.white)
                                .background(Circle()
                                                .fill(Color.black)
                                                .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                                .offset(x: 15, y: 15)
                        }
                        Spacer()
                        Image("history")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                            .onTapGesture {
                                print("Show History Trainings")
                            }
                    }.padding(.all, 20)
                    List(asanasList.asanas.indices, id: \.self) {
                        ind in
                        AsanaRow(asana: $asanasList.asanas[ind])
                        
                    }
                    .listStyle(PlainListStyle())
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.black)
                            .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Move On")
                            .foregroundColor(.white)
                    } .onTapGesture {
                        isPresented.toggle()
                    }
                    .fullScreenCover(isPresented:
                                    $isPresented, content: Questions.init)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)

                    .offset(x: self.showAddedAsanasView ? geometry.size.width/2 + 100 : 0)
                    .disabled(self.showAddedAsanasView ? true : false)
            }
            
            if self.showAddedAsanasView {
                SlideViewWithAddedAsanas(asanasList: $asanasList.asanas)
                    .frame(width: geometry.size.width/2 + 100)
                    .transition( .move(edge: .leading))
                    .shadow(radius: 30)
                    
            }
        }.gesture(drag)
    }
}

struct AsanasCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AsanasCollectionView( asanasList: AsanaList())
    }
}
