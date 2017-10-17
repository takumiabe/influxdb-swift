//
//  InfluxDBError.swift
//  UserActivityLogger
//
//  Created by takumiabe on 2017/09/28.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

public struct InfluxDBError: Error {
    public let message: String

    public init(object: Any) {
        let dic = object as? [String: Any]
        self.message = dic?["error"] as? String ?? "unknown error"
    }
}
