import Foundation

final class DecodingNetworkResponseConverter<Response>: NetworkResponseConverter where Response: Decodable {
    
    func decodeResponse(from data: Data) -> Response? {
        //print("DATA = \(String(data: data, encoding: .utf8))")
        let resp = try? JSONDecoder().decode(Response.self, from: data)
        //print("RESPONSE = \(resp)")
        return resp
    }
}

