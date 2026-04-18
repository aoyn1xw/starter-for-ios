import Appwrite
import Foundation

let client = Client()
    .setEndpoint("https://fra.cloud.appwrite.io/v1")
    .setProject("698239cb000237ba7193")

let account = Account(client)

extension Client {
    func ping() async throws -> String {
        let url = URL(string: endPoint + "/ping")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "InvalidResponse", code: 0)
        }

        guard httpResponse.statusCode == 200 else {
            throw NSError(
                domain: "PingError",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "Request failed with status code \(httpResponse.statusCode)"]
            )
        }

        return String(data: data, encoding: .utf8) ?? "pong"
    }
}

/// A class that provides convenient access to Appwrite API methods for interacting with the project, account, and databases.
class AppwriteSDK: ObservableObject {
    private let APPWRITE_PROJECT_ID = "698239cb000237ba7193"
    private let APPWRITE_PROJECT_NAME = "New project"
    private let APPWRITE_PUBLIC_ENDPOINT = "https://fra.cloud.appwrite.io/v1"
    
    /// Returns project-related information such as endpoint, project ID, name, and version.
    func getProjectInfo() -> (endpoint: String, projectId: String, projectName: String, version: String) {
        return (
            APPWRITE_PUBLIC_ENDPOINT,
            APPWRITE_PROJECT_ID,
            APPWRITE_PROJECT_NAME,
            client.headers["x-appwrite-response-format"] ?? "1.6.0"
        )
    }
    
    /// Performs a ping request to the Appwrite API and returns the response as a `Log`.
    /// - Returns: A `Log` object representing the ping request's result.
    func ping() async -> Log {
        do {
            let response = try await client.ping()
            return Log(
                date: getCurrentDate(),
                status: "200",
                method: "GET",
                path: "/ping",
                response: String(describing: response)
            )
        } catch {
            return Log(
                date: getCurrentDate(),
                status: "Error",
                method: "GET",
                path: "/ping",
                response: "Request failed: \(error.localizedDescription)"
            )
        }
    }
    
    /// Returns the current date formatted as "MMMM dd, HH:mm".
    /// - Returns: A string representing the current date.
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, HH:mm"
        return formatter.string(from: Date())
    }
    
}
