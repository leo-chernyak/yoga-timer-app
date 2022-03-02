//
//  TimerView.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 28.07.2021.
//

import SwiftUI
import AVKit


struct TimerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var timeRemaining: Int?
    @State var asanaAmount: Int?
    @State var restTime: Int?
    static var asanaTime: Int?
    static var restTime: Int?
    @State var isResting: Bool = false
    @State var timerIsRunning: Bool = false
    @State var quotes: [Quote]
    @State var quoteNum: Int!
    
    
    @State var timer: Timer? = nil
    @State var player: AVAudioPlayer!
    
    var body: some View {
        VStack {
            Text(timerIsRunning ? quotes[quoteNum].text! : "")
                .italic()
                .padding(.all, 40)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .lineLimit(nil)
                .animation(.easeInOut(duration: 2))
            Text(timerIsRunning ? quotes[quoteNum].author ?? "Nobody" : "")
                .italic()
                .padding(.all, 20)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .lineLimit(nil)
                .animation(.easeInOut(duration: 2))
            Spacer(minLength: 20)
            ZStack {
                Circle()
                    .fill(isResting ? Color.white : Color.black)
                    .animation(.easeInOut(duration: 5))
                    .shadow(radius: 10)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text( isResting ? "\(String(restTime ?? 30) )" : "\(String(timeRemaining ?? 30) )")
                    .foregroundColor(isResting ? Color.black : Color.white)
                    .fontWeight(.medium)
                    .font(.custom("Helvetica", fixedSize: 70))
                    .frame(width: 300, height: 300)
                    .ignoresSafeArea(.all, edges: .all)
                    .padding(.all, 1)
                    .animation(.linear(duration: 1))
                    
            }
            Spacer()
            Text("Asanas left: \(String(asanaAmount ?? 20) )")
                .italic()
                .foregroundColor(.black)
                .padding(.all, 5)
                .multilineTextAlignment(.center)
                .lineLimit(0)
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .shadow(radius: 20)
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button(timerIsRunning ? "Cancel" : "Start") {
                        if timerIsRunning {
                            timer?.invalidate()
                            timer = nil
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            startTimer()
                            print("Start")
                        }
                    }.foregroundColor(.white)
                    .font(.headline)
                }
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                Spacer()
            } .padding(.all, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func startTimer() {
        quoteNum = Int.random(in: 0...quotes.count - 1)
        timerIsRunning = true
        TimerView.asanaTime = timeRemaining
        TimerView.restTime = restTime
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timerIn) in
                        timeRemaining = (timeRemaining ?? 30) - 1
            if timeRemaining == 0 {
                asanaAmount = (asanaAmount ?? 10) - 1
                isResting = true
                timeRemaining = TimerView.asanaTime
                timer?.invalidate()
                timer = nil
                if asanaAmount == 0 {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    quoteNum = Int.random(in: 0...quotes.count - 1)
                    playSoud()
                    startRest()
                }
                
            }
        })
    }
    
    func startRest() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timerIn) in
            restTime = (restTime ?? 30) - 1
            print("Bad")
            if restTime == 0 {
                quoteNum = Int.random(in: 0...quotes.count - 1)
                playSoud()
                isResting = false
                restTime = TimerView.restTime
                timer?.invalidate()
                timer = nil
                startTimer()
            }
        })
    }
    
    func playSoud() {
        if  let soundPath = Bundle.main.path(forResource: "gong", ofType: "mp3") {
            do {
                try AVAudioSession.sharedInstance()
                    .setCategory(.playback, options: .duckOthers)
                try AVAudioSession.sharedInstance()
                    .setActive(true)
                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
                self.player.play()
            } catch {
                print(error)
            }
        }
        
    }
}

extension AnyTransition {
    static func moveAndScale(edge: Edge, scale: CGFloat) -> AnyTransition {
        AnyTransition.move(edge: edge).combined(with: .scale(scale: scale))
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: 30, quotes: [Quote](), player: AVAudioPlayer())
    }
}
