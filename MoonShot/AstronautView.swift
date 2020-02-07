//
//  AstronautView.swift
//  MoonShot
//
//  Created by Elias Myronidis on 7/2/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionNames: [String]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [String]()
        
        for mission in missions {
            for crew in mission.crew {
                if astronaut.id == crew.name {
                    print(astronaut.id)
                    matches.append(mission.displayName)
                }
            }
        }
        
        missionNames = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Missions took part")
                        .font(.headline)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        
                    
                    ForEach(self.missionNames, id: \.self) { name in
                        Text(name)
                        .italic()
                    }
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7], missions: missions)
    }
}
