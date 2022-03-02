//
//  Questions.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 29.07.2021.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
            .cornerRadius(3)
            .multilineTextAlignment(.center)
            .font(.custom("Helvetica", fixedSize: 30))
            .keyboardType(.numberPad)
            
            
    }
}

struct Questions: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var questions: [String] = ["How many asanas are you gonna to do?","Whats time for every asana?","Whats time for going to next asana?"]
    @State var amountAsanas: String = ""
    @State var timeAsana: String = ""
    @State var timeRest: String = ""
    @State var textFieldText: String = ""
    @State var counterQuestions: Int = 0
    @State var readyForTimer: Bool = false
    @State var placeHolder: String = "Amount"
    @State var imageName: String = "yoga-1"
    @ObservedObject var networkingManager = NetworkingManager()
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
//                    self.showAddedAsanasView.toggle()
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()

                    }
                }
            }
        
        
        
        NavigationView {
        VStack(alignment: .center) {
            
            NavigationLink(destination: TimerView(timeRemaining: Int(timeAsana), asanaAmount: Int(amountAsanas), restTime: Int(timeRest), quotes: networkingManager.dataList), isActive: $readyForTimer)
                { EmptyView() }
                
            

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
                .padding(.all)
                .animation(.easeInOut)
            
            Text(questions[counterQuestions])
                .italic()
                .font(.custom("Helvetica", size: 20))
                .animation(.easeInOut)
            TextField("\(placeHolder)", text: $textFieldText, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
            })  {
                print("Username onCommit")
            }
            .animation(.easeInOut)
            .textFieldStyle(CustomTextFieldStyle())
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.black)
                    .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button("Accept") {
                    if textFieldText != "" {
                        switch counterQuestions {
                        case 0:
                            readyForTimer = false
                             counterQuestions += 1
                            placeHolder = "Seconds"
                            amountAsanas = textFieldText
                            textFieldText = ""
                            imageName = "yoga-2"
                        case 1:
                            readyForTimer = false
                            counterQuestions += 1
                            timeAsana = textFieldText
                            placeHolder = "Seconds"
                            textFieldText = ""
                            imageName = "yoga-3"
                        case 2:
                            counterQuestions = 0
                            timeRest = textFieldText
                            textFieldText = ""
                            placeHolder = "Amount"
                            readyForTimer = true
                        default:
                            print("ASS")
                        }
                    } else {
                        placeHolder = "Please fill"
                    }
                    
                    
                } .foregroundColor(.white)
                .font(.custom("Helvetica", size: 30))
            }
            Spacer()
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .onTapGesture {
            hideKeyboard()
        }
        }
        .gesture(drag)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct Questions_Previews: PreviewProvider {
    static var previews: some View {
        Questions()
    }
}
