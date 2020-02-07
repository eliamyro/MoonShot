//
//  ContentView.swift
//  MoonShot
//
//  Created by Elias Myronidis on 7/2/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var mode: Bool = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        Text(self.mode ? mission.formattedLaunchDate : self.crewNames(of: mission))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button (mode ? "Crew" : "Dates") {
                self.mode.toggle()
            })
        }
    }
    
    private func crewNames(of mission: Mission) -> String {
        var names: String = ""
        
        for crew in mission.crew {
            for astronaut in astronauts {
                if crew.name == astronaut.id {
                    names += "\(astronaut.name)\n"
                }
            }
        }
        
        return names.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE")
    }
}
