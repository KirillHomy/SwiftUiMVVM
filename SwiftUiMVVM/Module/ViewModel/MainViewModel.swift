//
//  MainViewModel.swift
//  SwiftUiMVVM
//
//  Created by Kirill Khomicevich on 21.12.2024.
//

import SwiftUI

protocol MainViewModelProtocol {
    
}

extension MainContentView {
    @Observable
    class MainViewModel: MainViewModelProtocol {
        
        private let networkHelper = NetworkHelper()
        var searchText: String = ""
        private(set) var mainModel: [Article] = []
    
        func sendRequest() {

            networkHelper.fetchData(q: searchText) { (result: Result<ResponseModel, ErrorList>) in
                  switch result {
                  case .success(let response):
                          self.mainModel = response.articles
                          print("print \(self.mainModel.count)")
                          self.mainModel.forEach { print($0.author) }
                      // Обрабатываем успешный ответ
                      print("Получены данные: \(response)")
                  case .failure(let error):
                      // Обрабатываем ошибку
                      print("Произошла ошибка: \(error)")
                  }
              }
        }
        
    }
}
