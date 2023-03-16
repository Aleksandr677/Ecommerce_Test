//
//  DetailViewService.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-15.
//

import Foundation
import Combine

class DetailViewService {
    @Published var details: Details? = nil
    var detailsSubscription: AnyCancellable?
    
    init() {
        getDetails()
    }
    
    private func getDetails() {
        guard let url = URL(string: "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239") else { return }
        
        detailsSubscription = NetworkingManager.download(url: url)
            .decode(type: Details.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (returnedDetails) in
                self?.details = returnedDetails
                self?.detailsSubscription?.cancel()
            })
    }
}
