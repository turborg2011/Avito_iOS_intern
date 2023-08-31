struct DetailAdvertisement: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case image_url
        case created_date
        case description
        case email
        case phone_number
        case address
    }
}
