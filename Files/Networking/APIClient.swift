//
//  APIClient.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import Foundation

final class APIClient {

    static let shared = APIClient()
    private init() {}

    private let session = URLSession(configuration: .default)

    // MARK: - DataTask
    func request<T: Decodable>(
        api: SampleAPI,
        body: Data? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: api.url)
        request.httpMethod = api.method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(APIError.decodingFailed))
            }

        }.resume()
    }

    // MARK: - UploadTask
    func upload(
        api: SampleAPI,
        data: Data,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        var request = URLRequest(url: api.url)
        request.httpMethod = api.method

        let task = session.uploadTask(with: request, from: data) {
            responseData, _, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(responseData ?? Data()))
        }

        task.resume()
    }

    // MARK: - DownloadTask with Progress
    func download(
        api: SampleAPI,
        progress: @escaping (Double) -> Void,
        completion: @escaping (Result<URL, Error>) -> Void
    ) {
        let task = session.downloadTask(with: api.url) {
            tempURL, _, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let tempURL else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.noData))
                }
                return
            }

            do {
                let documents = FileManager.default.urls(
                    for: .documentDirectory,
                    in: .userDomainMask
                )[0]

                let destination = documents.appendingPathComponent("sample.bin")

                if FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }

                try FileManager.default.copyItem(at: tempURL, to: destination)

                DispatchQueue.main.async {
                    completion(.success(destination))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        // Observe progress
        let observation = task.progress.observe(
            \.fractionCompleted,
            options: [.new]
        ) { progressObj, _ in
            DispatchQueue.main.async {
                progress(progressObj.fractionCompleted)
            }
        }

        task.resume()

        //Keep observer alive
        objc_setAssociatedObject(
            task,
            &ProgressObserverKey.key,
            observation,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}

private struct ProgressObserverKey {
    static var key: UInt8 = 0
}
