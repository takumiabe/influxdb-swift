//
//  InfluxDBRequest.swift
//  UserActivityLogger
//
//  Created by takumiabe on 2017/09/28.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

import APIKit

protocol InfluxDBRequest: Request {
    var influxdb: InfluxDBClient { get }
}

extension InfluxDBRequest {
    typealias Response = InfluxDBResponse

    var baseURL: URL {
        return self.influxdb.host
    }

    // 異常終了時はJSONが返ってくるので、InfluxDBErrorでパースさせる
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            print(urlResponse)
            print(object)
            throw InfluxDBError.init(object: object)
        }
        return object
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard (200..<300).contains(urlResponse.statusCode) else {
            print(urlResponse)
            print(object)
            throw InfluxDBError.init(object: object)
        }

        if urlResponse.statusCode == 204 {
            return .noContent
        }

        if let json = object as? [String: Any],
           let results = json["results"] as? [Any] {
            return .results(results)
        }
        return .unknown(object)
    }
}
