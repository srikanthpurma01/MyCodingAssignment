import Foundation

protocol MembersInteractorProtocol {
    func fetchMembersResults(name: String, completion: @escaping (Result<[Members], Error>) -> Void)
}

class MembersInteractor: MembersInteractorProtocol {
    
    func fetchMembersResults(name: String, completion: @escaping (Result<[Members], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    struct APIResponse: Codable {
        let results: [Members]
    }
}
