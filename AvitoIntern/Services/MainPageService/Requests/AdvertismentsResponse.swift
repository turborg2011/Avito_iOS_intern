import Foundation

struct AdvertismentsResponse: Decodable {
    var advertisments: [Advertisment]

    init(from decoder: Decoder) throws {
        let container = try decoder.container()
        advertisments = try container.decode(key: "advertisements")
    }
}
