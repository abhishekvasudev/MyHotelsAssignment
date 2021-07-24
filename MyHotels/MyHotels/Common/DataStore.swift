//
//  DataStore.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 22/07/21.
//

import Foundation

class DataStore {
    private var hotels: [Hotel] = []
    
    func fetchHotels() -> [Hotel] {
        hotels
    }
    
    func addHotel(hotel: Hotel) {
        hotels.append(hotel)
    }
    
    func editHotel(hotel: Hotel, at index: Int) {
        hotels.remove(at: index)
        hotels.insert(hotel, at: index)
    }
    
    func removeHotel(at index: Int) {
        hotels.remove(at: index)
    }
}
