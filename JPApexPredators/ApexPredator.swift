import Foundation
import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    var movies: [String]
    var movieScenes: [MovieScene]
    var link: String
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum PredatorType: String, Decodable, CaseIterable, Identifiable {
        case all
        case land
        case air
        case sea
        
        var id: PredatorType {
            self
        }
        
        var background:Color {
            switch self {
            case .all:
                    .black
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            }
        }
        
        var icon: String {
            switch self {
            case .land:
                "leaf.fill"
            case .air:
                "wind"
            case .sea:
                "drop.fill"
            case .all:
                "square.stack.3d.up.fill"
            }
        }
    }
    
}

