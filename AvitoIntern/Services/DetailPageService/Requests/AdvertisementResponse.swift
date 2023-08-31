import Foundation

struct AdvertisementResponse: Decodable {
    var advertisement: DetailAdvertisement

    init(from decoder: Decoder) throws {
        let container = try decoder.container()

        advertisement = DetailAdvertisement(id: try container.decode(key: "id"),
                                            title: try container.decode(key: "title"),
                                            price: try container.decode(key: "price"),
                                            location: try container.decode(key: "location"),
                                            image_url: try container.decode(key: "image_url"),
                                            created_date: try container.decode(key: "created_date"),
                                            description: try container.decode(key: "description"),
                                            email: try container.decode(key: "email"),
                                            phone_number: try container.decode(key: "phone_number"),
                                            address: try container.decode(key: "address"))
    }
}
