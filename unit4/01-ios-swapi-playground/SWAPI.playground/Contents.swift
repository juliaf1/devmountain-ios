import Foundation

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
