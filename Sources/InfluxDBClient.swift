//
//  InfluxDBClient.swift
//  InfluxDBSwift
//
//  Created by takumiabe on 2017/09/28.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

import APIKit

class InfluxDBClient {
    typealias Tags = [String: String]
    typealias Fields = [String: String]

    let host: URL
    let dbName: String

    init(host: URL, databaseName: String) {
        self.host = host
        self.dbName = databaseName
    }

    func createDatabase(database: String) {
        send(QueryRequest(influxdb: self, query: "CREATE DATABASE \(database)"))
    }

    func dropDatabase(database: String) {
        send(QueryRequest(influxdb: self, query: "DROP DATABASE \(database)"))
    }

    func write(measurement: String, tags: Tags = [:], fields: Fields) {
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
