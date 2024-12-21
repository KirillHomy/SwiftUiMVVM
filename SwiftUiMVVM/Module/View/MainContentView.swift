//
//  ContentView.swift
//  SwiftUiMVVM
//
//  Created by Kirill Khomicevich on 21.12.2024.
//

import SwiftUI

struct MainContentView: View {
    @State var mainViewModel = MainViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(mainViewModel.mainModel, id: \.self) { model in
                    VStack {
                        Text(model.author ?? "")
                            .font(.headline)
                        Text(model.title ?? "")
                            .font(.title)
                    }
                }
            }
        }
        .searchable(text: $mainViewModel.searchText)
        .navigationTitle("SwiftUiMVVM")
        .onSubmit(of: .search) {
            mainViewModel.sendRequest()
        }
        
    }
}

#Preview {
    MainContentView()
}
