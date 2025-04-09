import Foundation

struct Members: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let origin: Origin
    let image: String
    let created: String

    struct Origin: Codable {
        let name: String
    }
}
