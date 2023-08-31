import Foundation
import Combine
import SwiftUI

@Observable
class HotelViewModel {
    private let service = HotelService()
    
    var hotel: APIResult<HotelModel> = .loading
    
    init() {
        fetchHotel()
    }
    
    func fetchHotel() {
        Task {
            let result = await service.fetchHotel()
            Task { @MainActor in
                hotel = result
            }
        }
    }
}
