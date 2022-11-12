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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Error & Response Handling
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let status = response.statusCode
                if status != 200 {
                    print("Status code for \(#function): \(status)")
                }
            }
            
            // Data Unwrapping
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // Data Decoding
            
            do {
                let film = try JSONDecoder().decode(Film.self, from: data)
                return completion(.success(film))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
}

// MARK: - Helpers

enum SwapiError: LocalizedError {
    
    case invalidURL
    case noData
    case thrownError(Error)

}

// MARK: - Usage

func fetchAndPrintFilm(for url: URL) {
    SwapiService.fetchFilm(for: url) { result in
        switch result {
        case .success(let film):
            print(film)
        case .failure(let error):
            print(error)
        }
    }
}

SwapiService.fetchPerson(for: 1) { result in
    switch result {
    case .success(let person):
        print(person)
        for filmURL in person.films {
            fetchAndPrintFilm(for: filmURL)
        }
    case .failure(let error):
        print(error)
    }
}
