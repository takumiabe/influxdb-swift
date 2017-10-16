//
//  QueryRequest.swift
//  InfluxDBSwift
//
//  Created by takumiabe on 2017/10/13.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

import APIKit

class QueryRequest: InfluxDBRequest {
    let influxdb: InfluxDBClient

    let query: String
    let database: String?

    init(influxdb: InfluxDBClient, query: String, database: String? = nil) {
        self.influxdb = influxdb
        self.query = query
        self.database = database
    }

    var method = HTTPMethod.post
    var path = "/query"

    var queryParameters: [String: Any]? {
        if self.database != nil {
            return ["q": self.query, "db": self.database!]
        } else {
            return ["q": self.query]
        }
    }
}
