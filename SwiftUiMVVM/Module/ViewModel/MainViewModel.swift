//
//  MainViewModel.swift
//  SwiftUiMVVM
//
//  Created by Kirill Khomicevich on 21.12.2024.
//

import SwiftUI

protocol MainViewModelProtocol: AnyObject {
    var searchText: String { get set }
    var mainModel: [Article] { get }
    
    func sendRequest()
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
                      print("Получены данные: \(response)")
                  case .failure(let error):
                      print("Произошла ошибка: \(error)")
                  }
              }
        }
    }
}
