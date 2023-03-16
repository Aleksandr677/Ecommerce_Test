//
//  FlashSaleCategoryService.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-14.
//

import Foundation
import Combine

class FlashSaleCategoryService {
    @Published var allFlashSale: [ItemFlashSaleCategory] = []
    var flashSaleSubscription: AnyCancellable?
    
    init() {
        getFlashSale()
    }
    
    private func getFlashSale() {
        guard let url = URL(string: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac") else { return }
        
        flashSaleSubscription = NetworkingManager.download(url: url)
            .decode(type: FlashSaleCategory.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (returnedItems) in
                self?.allFlashSale = returnedItems.flashSale
                self?.flashSaleSubscription?.cancel()
            })
    }
}
