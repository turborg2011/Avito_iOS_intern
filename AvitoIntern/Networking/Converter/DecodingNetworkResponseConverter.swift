import Foundation

final class DecodingNetworkResponseConverter<Response>: NetworkResponseConverter where Response: Decodable {
    
    func decodeResponse(from data: Data) -> Response? {
        let resp = try? JSONDecoder().decode(Response.self, from: data)
        return resp
    }
}

