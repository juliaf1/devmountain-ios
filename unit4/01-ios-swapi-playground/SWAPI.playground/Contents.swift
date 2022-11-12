import Foundation

// MARK: - Models

struct Person: Decodable {

    let name: String
    let films: [URL]

}

struct Film: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case openingCrawl = "opening_crawl"
        case releaseDate = "release_date"
    }
    
    let title: String
    let openingCrawl: String
    let releaseDate: String
    
}

// MARK: - Controllers

class SwapiService {
    
    // MARK: - Properties
    
    static let baseURL = "https://swapi.dev/api"
    static let personEP = "people"
    static let filmEP = "films"
    
    // MARK: - Methods
    
    static func fetchPerson(for id: Int, completion: @escaping () -> Void) {
        
    }
    
    static func fetchFilm(for url: URL, completion: @escaping () -> Void) {
        
    }
    
}
