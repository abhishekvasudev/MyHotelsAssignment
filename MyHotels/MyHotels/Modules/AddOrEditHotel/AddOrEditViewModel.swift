//
//  AddOrEditViewModel.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 24/07/21.
//

import UIKit

class AddOrEditViewModel {
    
    private var dataStore: DataStore
    private var hotel: Hotel?
    private var hotelPosition: Int?
    private var hotelName: String?
    private var hotelAddress: String?
    private var dateOfStay: Date?
    private var roomRate: Int?
    private var hotelRating: Int?
    private var image: UIImage?
    
    var hasValueChanged: Bool = false
    
    var isEditMode: Bool {
        guard let _ = hotel else { return false }
        return true
    }
    
    init(dataStore: DataStore, hotel: Hotel? = nil, hotelPosition: Int? = nil) {
        self.dataStore = dataStore
        self.hotel = hotel
        self.hotelPosition = hotelPosition
        self.hotelName = hotel?.name
        self.hotelAddress = hotel?.address
        self.dateOfStay = hotel?.dateOfStay
        self.roomRate = hotel?.roomRate
        self.hotelRating = hotel?.hotelRating
        self.image = hotel?.photo
    }
    
    func addHotel() {
        let hotel = Hotel(id: UUID().uuidString,
                          name: hotelName ?? "NA",
                          address: hotelAddress ?? "NA",
                          dateOfStay: dateOfStay ?? Date(),
                          roomRate: roomRate ?? 0,
                          hotelRating: hotelRating ?? 1,
                          photo: image)
        
        dataStore.addHotel(hotel: hotel)
    }
    
    func editHotel() {
        if let hotelPosition = hotelPosition, let hotel = hotel {
            let editedHotel = Hotel(id: hotel.id,
                                    name: hotelName ?? hotel.name,
                                    address: hotelAddress ?? hotel.address,
                                    dateOfStay: dateOfStay ?? hotel.dateOfStay,
                                    roomRate: roomRate ?? hotel.roomRate,
                                    hotelRating: hotelRating ?? hotel.hotelRating,
                                    photo: image ?? hotel.photo)
            dataStore.editHotel(hotel: editedHotel, at: hotelPosition)
        }
    }
    
    func deleteHotel() {
        if let hotelPosition =  hotelPosition {
            dataStore.removeHotel(at: hotelPosition)
        }
    }
    
    func getHotel() -> Hotel? {
        hotel
    }
    
    func setName(name: String) {
        self.hotelName = name
    }
    
    func setAddress(address: String) {
        self.hotelAddress = address
    }
    
    func setDateOfStay(date: Date) {
        self.dateOfStay = date
    }
    
    func setRoomRate(roomRate: Int) {
        self.roomRate = roomRate
    }
    
    func setRating(rating: Int) {
        self.hotelRating = rating
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func checkIfValuesChanged() {
        if hotelName != hotel?.name
            || hotelAddress != hotel?.address
            || dateOfStay != hotel?.dateOfStay
            || roomRate != hotel?.roomRate
            || hotelRating != hotel?.hotelRating
            || image != hotel?.photo {
            hasValueChanged = true
        } else {
            hasValueChanged = false
        }
    }
}
