//
//  LatestCategoryService.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-13.
//

import Foundation
import Combine

class LatestCategoryService {
    @Published var allLatest: [ItemLatestCategory] = []
    var latestSubscription: AnyCancellable?
    
    init() {
        getLatest()
    }
    
    private func getLatest() {
        guard let url = URL(string: "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7") else { return }
        
        latestSubscription = NetworkingManager.download(url: url)
            .decode(type: LatestCategory.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (returnedItems) in
                self?.allLatest = returnedItems.latest
                self?.latestSubscription?.cancel()
            })
    }
}
