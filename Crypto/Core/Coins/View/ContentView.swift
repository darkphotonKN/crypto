//
//  ContentView.swift
//  Crypto
//
//  Created by Kranti on 2023/11/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinViewModel()
    
    var body: some View {
        
        List {
            Text("\(viewModel.coin): \(viewModel.price)");
        }
       
    }
}

#Preview {
    ContentView()
}
