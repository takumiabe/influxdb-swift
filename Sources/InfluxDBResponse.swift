//
//  InfluxDBResponse.swift
//  InfluxDBSwift
//
//  Created by takumiabe on 2017/09/28.
//  Copyright © 2017年 takumiabe. All rights reserved.
//

enum InfluxDBResponse {
    case noContent
    case results([Any])
    case unknown(Any)
}
