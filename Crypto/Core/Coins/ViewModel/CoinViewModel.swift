//
//  CoinViewModel.swift
//  Crypto
//
//  Created by Kranti on 2023/11/11.
//

import Foundation

class CoinViewModel: ObservableObject {
    @Published var coin = "";
    @Published var price = "";
    
    init() {
        fetchCoin(coin: "ethereum");
    }
        
    // fetches coingecko api for a list of crypto info
    func fetchCoin(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin),ethereum,dogecoin&vs_currencies=usd";
        
        guard let url = URL(string: urlString) else {
            print("Url is not valid.");
            return }
        
        
        // passes url check, fetches data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // check data validity
            guard let data = data else { return } // return if we can't get data
            
            // serialize JSON and check validity
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return } // also casts to a Dictionary
            
            // further cast the inner values to Dictionaries too
            guard let value = jsonObj[coin] as? [String: Double] else { return }
            
            // get price from the Opitional value
            guard let price = value["usd"] else { return }
            
            // Gets us back to the main thread to update these properties
            DispatchQueue.main.async {
                self.coin = "\(coin)";
                self.price = "$\(price)";
            }
            
            
            print("final value: \(value)");
        }.resume();
        
    }
}
