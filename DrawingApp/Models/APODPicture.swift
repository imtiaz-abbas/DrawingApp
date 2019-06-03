// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPODPicture = try APODPicture(json)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - APODPicture
public struct APODPicture: Codable, Equatable {
  public let copyright: String?
  public let date: String?
  public let explanation: String?
  public let hdurl: String?
  public let mediaType: String?
  public let serviceVersion: String?
  public let title: String?
  public let url: String?

  enum CodingKeys: String, CodingKey {
    case copyright = "copyright"
    case date = "date"
    case explanation = "explanation"
    case hdurl = "hdurl"
    case mediaType = "media_type"
    case serviceVersion = "service_version"
    case title = "title"
    case url = "url"
  }

  public init(copyright: String?, date: String?, explanation: String?, hdurl: String?, mediaType: String?, serviceVersion: String?, title: String?, url: String?) {
    self.copyright = copyright
    self.date = date
    self.explanation = explanation
    self.hdurl = hdurl
    self.mediaType = mediaType
    self.serviceVersion = serviceVersion
    self.title = title
    self.url = url
  }
}

// MARK: APODPicture convenience initializers and mutators

public extension APODPicture {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(APODPicture.self, from: data)
  }

  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

  init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }

  func with(
    copyright: String?? = nil,
    date: String?? = nil,
    explanation: String?? = nil,
    hdurl: String?? = nil,
    mediaType: String?? = nil,
    serviceVersion: String?? = nil,
    title: String?? = nil,
    url: String?? = nil
    ) -> APODPicture {
    return APODPicture(
      copyright: copyright ?? self.copyright,
      date: date ?? self.date,
      explanation: explanation ?? self.explanation,
      hdurl: hdurl ?? self.hdurl,
      mediaType: mediaType ?? self.mediaType,
      serviceVersion: serviceVersion ?? self.serviceVersion,
      title: title ?? self.title,
      url: url ?? self.url
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - Helper functions for creating encoders and decoders

private func newJSONDecoder() -> JSONDecoder {
  let decoder = JSONDecoder()
  if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
    decoder.dateDecodingStrategy = .iso8601
  }
  return decoder
}

private func newJSONEncoder() -> JSONEncoder {
  let encoder = JSONEncoder()
  if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
    encoder.dateEncodingStrategy = .iso8601
  }
  return encoder
}
