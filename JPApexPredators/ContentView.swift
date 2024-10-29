//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Bugrahan on 28.10.2024.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = true
    @State var currentSelection: ApexPredator.PredatorType = .all
    var filteredPredators: [ApexPredator] {
        predators.filter(by: currentSelection)
        
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink{
                    PredatorView(predator: predator)
                } label: {
                    HStack {
                        // Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .font(.headline)
                                .fontWeight(.bold)
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .searchable(text: $searchText, prompt: "Search for a predator")
            .animation(.default, value: searchText)
            .navigationTitle("Apex Predators")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "textformat" : "film")
                            .symbolEffect(.bounce, value: alphabetical)
                    }

                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection) {
                            ForEach(ApexPredator.PredatorType.allCases) {
                                type in
                                Label {
                                    Text(type.rawValue.capitalized)
                                } icon: {
                                    Image(systemName: type.icon)
                                }

                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }

                }
            }
        }

    }
}

#Preview {
    ContentView()
}
