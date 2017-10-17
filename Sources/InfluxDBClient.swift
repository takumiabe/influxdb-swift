//
//  InfluxDBClient.swift
//  InfluxDBSwift
//
//  Created by takumiabe on 2017/09/28.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

import APIKit

open class InfluxDBClient {
    public typealias Tags = [String: String]
    public typealias Fields = [String: String]

    public let host: URL
    public let database: String

    public init(host: URL, databaseName: String) {
        self.host = host
        self.database = databaseName
    }

    open func createDatabase(database: String) {
        send(QueryRequest(influxdb: self, query: "CREATE DATABASE \(database)"))
    }

    open func dropDatabase(database: String) {
        send(QueryRequest(influxdb: self, query: "DROP DATABASE \(database)"))
    }

    open func write(measurement: String, tags: Tags = [:], fields: Fields) {
        send(WriteRequest.init(influxdb: self, measurement: measurement, tags: tags, fields: fields))
    }

    private func send<R: InfluxDBRequest>(_ request: R) {
        Session.send(request) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
