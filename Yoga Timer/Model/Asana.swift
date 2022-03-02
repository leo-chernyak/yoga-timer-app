//
//  Asana.swift
//  Yoga Timer
//
//  Created by Leo Chernyak on 01.08.2021.
//

import Foundation


struct Asana: Identifiable, Hashable {
    var id  = UUID()
    var name: String
    var image: String
    var description: String
    var chakras: [String]
    var isChoosed: Bool
}

class AsanaList: ObservableObject {
    @Published var asanas: [Asana]
    init() {
        asanas = [
            Asana(name: "Chataranga", image: "yoga-1", description: "The Sanskrit word chatominent in literature. Several min the Kushan Empire ca. 50 B.C.–200 A.D. and draws not only on Indian games but on the Chinese game of Liubo and Chinese and Babylonian divination techniques.", chakras: ["chakra-1","chakra-2"], isChoosed: false),
            Asana(name: "Crown", image: "yoga-2", description: "description", chakras: ["chakra-1"], isChoosed: false),
            Asana(name: "HeadStand", image: "yoga-3", description: "description", chakras: ["chakra-1","chakra-2","chakra-3"], isChoosed: false),
            Asana(name: "Hakashtanga", image: "yoga-2", description: "description", chakras: ["chakra-1","chakra-2","chakra-3"], isChoosed: false)]
    }
}
