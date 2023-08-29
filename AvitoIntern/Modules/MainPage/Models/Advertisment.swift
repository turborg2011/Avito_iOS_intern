struct Advertisment: Codable {
    
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case image_url
        case created_date
    }
}
