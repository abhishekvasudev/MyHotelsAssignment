//
//  HomeViewModel.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 22/07/21.
//

import Foundation


protocol HomeViewModelDelegate: class {
    func checkForEmptyViewAppearance()
}

class HomeViewModel {
    
    private var dataStore: DataStore
    private weak var delegate: HomeViewModelDelegate?
    
    init(dataStore: DataStore, _ delegate: HomeViewModelDelegate?) {
        self.dataStore = dataStore
        self.delegate = delegate
    }
    
    func fetchHotels() -> [Hotel] {
        dataStore.fetchHotels()
    }
    
    func removeHotel(at index: Int) {
        dataStore.removeHotel(at: index)
        delegate?.checkForEmptyViewAppearance()
    }
    
    func addHotel(hotel: Hotel) {
        dataStore.addHotel(hotel: hotel)
    }
    
    func getDataStore() -> DataStore {
        dataStore
    }
}
