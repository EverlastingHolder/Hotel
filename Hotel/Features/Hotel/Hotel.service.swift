import Foundation

protocol HotelServiceType {
    func fetchHotel() async -> APIResult<HotelModel>
}

final class HotelService: HotelServiceType {
    private let baseNetwork = Networking()
    
    func fetchHotel() async -> APIResult<HotelModel> {
        await baseNetwork.request("")
    }
}
