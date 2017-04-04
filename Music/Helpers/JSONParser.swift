import Foundation

typealias JSON = [String: AnyObject]

protocol JSONParseable {
    init?(response: JSON)
}

enum ParseError : Error {
    case keyNotFound(String)
    case typeMismatch(String, Any, Any)
}

public struct JSONParser {
    let dictionary: JSON?

    init(_ dictionary: JSON) {
        self.dictionary = dictionary
    }

    func fetch<T>(_ key: String) throws -> T {
        guard let object = dictionary?[key] else  {
            throw ParseError.keyNotFound(key)
        }

        guard let value = object as? T else {
            throw ParseError.typeMismatch(key, T.self, type(of: object))
        }

        return value
    }
}

protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}

protocol JSONSerializable: JSONRepresentable { }

extension JSONSerializable {
    var JSONRepresentation: Any {
        var representation = [String: Any]()

        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation
            case let value as NSObject:
                representation[label] = value
            default:
                break
            }
        }

        return representation as Any
    }
}

extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

public enum JSONDecoderError: Error {
    case invalidData
    case keyNotFound(String)
    case keyPathNotFound(String)
}

public struct JSONDecoder {
    private let json: JSON

    public init(data: Data) throws {
        if let JSONData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
            self.json = JSONData
        } else {
            throw JSONDecoderError.invalidData
        }
    }
}
