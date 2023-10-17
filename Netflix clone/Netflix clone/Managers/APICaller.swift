//
//  APICaller.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import Foundation
struct Constants {
    static let API_KEY = "1330e694c7c90b77eee730df6ebb99fd"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzMwZTY5NGM3YzkwYjc3ZWVlNzMwZGY2ZWJiOTlmZCIsInN1YiI6IjVkZTI1NTcyZGNiNmEzMDAxMzZkODliZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A9tF7dI4jXuoLD662ZpJ8cAnJqvMnY3zJX-u5VPtkcE"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyAntQP3L2-ajEdQ7Kt_qnrC6D0g2RlAoj8"
    static let YoutubeURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
enum APIError: Error {
    case failedToGetData
}
class APICaller {
    static let shared = APICaller()
    
    private init() {
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?language=en-US") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?language=en-US") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func search(query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?query=\(query)") else {
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        session.resume()
        
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard let url = URL(string: "\(Constants.YoutubeURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        session.resume()
    }
}
