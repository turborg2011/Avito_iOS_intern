import Foundation

struct AdvertismentsResponse: Codable {
    let advertisments: [Advertisment]

    init(from decoder: Decoder) throws {
        let container = try decoder.container()
        advertisments = try container.decode(key: "advertisements")
    }
}
