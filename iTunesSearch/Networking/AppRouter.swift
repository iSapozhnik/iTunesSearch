//
//  AppRouter.swift
//  Airtruck
//
//  Created by Sapozhnik Ivan on 09.06.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import Foundation
import Alamofire

let baseURLString = "https://itunes.apple.com/"

enum AppRouter: URLRequestConvertible {
	case Artist([String:String])
	
	var method: Alamofire.Method {
		switch self {
		case .Artist:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .Artist(_):
			// stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()
			return baseURLString+"search"
		}
	}
	
	var URLRequest: NSMutableURLRequest {
		let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: path)!)
		mutableURLRequest.HTTPMethod = method.rawValue
		
		switch self {
		case .Artist(let params):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
		}
	}
}
