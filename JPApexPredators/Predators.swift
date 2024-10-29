import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding data from JSON: \(error)")
            }
        }
    }
    
    func search(for searchText:String) -> [ApexPredator] {
        if searchText.isEmpty {
            return self.apexPredators
        } else {
            return self.apexPredators.filter{ predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                return predator1.name < predator2.name
            } else {
                return predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: ApexPredator.PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter{ predator in
                type == predator.type
            }
        }
    }
}
