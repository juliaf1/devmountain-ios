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
    
    static let baseURL = URL(string: "https://swapi.dev/api")
    static let personEP = "people"
    static let filmEP = "films"
    
    // MARK: - Methods
    
    static func fetchPerson(for id: Int, completion: @escaping (Result<Person, SwapiError>) -> Void) {
        
        // 1. URL
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let personURL = baseURL.appendingPathComponent(personEP)
        let finalURL = personURL.appendingPathComponent(String(id))
        
        // 2. URL Session - Data Task
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            // 3. Error & Response Handling
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let status = response.statusCode
                if status != 200 {
                    print("Status Code in \(#function): \(status)")
                }
            }
            
            // 4. Data Unwrapping
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // 5. Data Decoding
            
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                return completion(.success(person))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    static func fetchFilm(for url: URL, completion: @escaping (Result<Film, SwapiError>) -> Void) {
        
    }
    
}

// MARK: - Helpers

enum SwapiError: LocalizedError {
    
    case invalidURL
    case noData
    case thrownError(Error)
    
}
