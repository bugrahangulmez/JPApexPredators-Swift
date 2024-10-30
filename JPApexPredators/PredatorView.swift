//
//  PredatorView.swift
//  JPApexPredators
//
//  Created by Bugrahan on 30.10.2024.
//

import SwiftUI
import MapKit

struct PredatorView: View {
    let predator: ApexPredator
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment:.bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.7),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width/1.5, height: geometry.size.height * 0.3)
                        .scaleEffect(x:-1)
                        .offset(y: 20)
                        .shadow(color: .black, radius: 7)
                    
                }
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    Text("Appears in:")
                        .font(.title3)
                    ForEach(predator.movies, id:\.self) { movie in
                        Text("•"+movie)
                            .font(.subheadline)
                    }
                    
                    Map(position: $position){
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "location.fill")
                            }
                        }
                    .frame(width: .infinity, height: 150)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    Text("Movie Movements")
                        .font(.title)
                        .padding(.top,15)
                    
                    ForEach(predator.movieScenes) { movieScene in
                        Text(movieScene.movie)
                            .font(.title2)
                            .padding(.vertical,1.5)
                        
                        Text(movieScene.sceneDescription)
                            .padding(.bottom,15)
                    }
                    
                    Link(destination: URL(string: predator.link)!) {
                        Text("Read More")
                    }
                    .padding(.bottom, 15)
                }
                .padding()
                .frame(width:geometry.size.width,alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    var pretador = Predators().apexPredators[5]
    PredatorView(
        predator: Predators().apexPredators[5],
        position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[5].location, distance: 1000))
    )
        .preferredColorScheme(.dark)
}
