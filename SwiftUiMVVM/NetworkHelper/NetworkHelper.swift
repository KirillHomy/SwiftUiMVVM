//
//  NetworkHelper.swift
//  SwiftUiMVVM
//
//  Created by Kirill Khomicevich on 21.12.2024.
//
import Foundation

enum ErrorList: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkHelper {
    let key = "699ebcfce68e4ba583695b6a9fed473b"
    func fetchData<T: Decodable>(q: String, completion: @escaping (Result<T, ErrorList>) -> Void) {
        var urlComponents = URLComponents(string: "https://newsapi.org/v2/everything")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "apiKey", value: key),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "language", value: "ru")
        ]
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }
                
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Лог JSON перед декодированием
            print(String(data: data, encoding: .utf8) ?? "Не удалось преобразовать JSON в строку")
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Или используйте .formatted(...)
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Ошибка декодирования: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
