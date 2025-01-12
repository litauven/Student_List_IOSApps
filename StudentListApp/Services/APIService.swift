//
//  APIService.swift
//  StudentListApp
//
//  Created by Seteven on 11/01/25.
//

import Foundation

class APIService {
    static func fetchStudents(completion: @escaping (Result<[Student], Error>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                print("Data error: \(error)")
                completion(.failure(error))
                return
            }

            if let str = String(data: data, encoding: .utf8) {
                print("Received data: \(str)")
            }

            do {
                let response = try JSONDecoder().decode(RandomUserResponse.self, from: data)
                let students = response.results.map { user in
                    Student(
                        id: user.id?.value ?? "Unknown",
                        name: "\(user.name.first) \(user.name.last)",
                        profilePicture: user.picture?.large ?? "",
                        address: "\(user.location?.city ?? "Unknown City"), \(user.location?.country ?? "Unknown Country")"
                    )
                }
                completion(.success(students))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
