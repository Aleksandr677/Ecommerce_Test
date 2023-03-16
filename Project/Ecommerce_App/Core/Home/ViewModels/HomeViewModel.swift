//
//  HomeViewModel.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-13.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allLatest: [ItemLatestCategory] = []
    @Published var allFlashSale: [ItemFlashSaleCategory] = []
    @Published var buyItems: [BuyItem] = []
    @Published var favoriteItems: [BuyItem] = []
    @Published var details: Details? = nil
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    private let latestCategoryService = LatestCategoryService()
    private let flashSaleCategoryService = FlashSaleCategoryService()
    private let detailViewService = DetailViewService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscription()
        isLoading = true
    }
    
    func addItemToBuy(price: Double, name: String, image: Image, color: Color) {
        let item = BuyItem(name: name, price: price, image: image, color: color)
        self.buyItems.append(item)
    }
    
    func addItemToFavorite(price: Double, name: String, image: Image) {
        let item = BuyItem(name: name, price: price, image: image)
        self.favoriteItems.append(item)
    }
    
    func addSubscription() {
        $searchText
            .combineLatest(latestCategoryService.$allLatest)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text, startingLatest) -> [ItemLatestCategory] in
                guard !text.isEmpty else {
                    return startingLatest
                }
                
                let lowercasedText = text.lowercased()
                
                return startingLatest.filter { (item) -> Bool in
                    return item.name.lowercased().contains(lowercasedText) || item.category.lowercased().contains(lowercasedText)
                }
            }
            .sink(receiveCompletion: { [weak self] (returnedLatest) in
                switch returnedLatest {
                case .failure:
                    self?.isLoading = true
                case .finished:
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] (returnedLatest) in
                self?.allLatest = returnedLatest
            })
            .store(in: &cancellables)
        
        $searchText
            .combineLatest(flashSaleCategoryService.$allFlashSale)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text, startingFlashSale) -> [ItemFlashSaleCategory] in
                guard !text.isEmpty else {
                    return startingFlashSale
                }
                
                let lowercasedText = text.lowercased()
                
                return startingFlashSale.filter { (item) -> Bool in
                    return item.name.lowercased().contains(lowercasedText) || item.category.lowercased().contains(lowercasedText)
                }
            }
            .sink(receiveCompletion: { [weak self] (returnedFlashSale) in
                switch returnedFlashSale {
                case .failure:
                    self?.isLoading = true
                case .finished:
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] (returnedFlashSale) in
                self?.allFlashSale  = returnedFlashSale
            })
            .store(in: &cancellables)
        
        detailViewService.$details
            .sink { [weak self] (details) in
                if details != nil {
                    self?.details = details
                }
            }
            .store(in: &cancellables)
    }
}
