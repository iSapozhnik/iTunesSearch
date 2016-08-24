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
	case Artist(String)
	
	var method: Alamofire.Method {
		switch self {
		case .Artist:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .Artist(let artistName):
			return baseURLString+"search?term=\(artistName)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
		}
	}
	
	var URLRequest: NSMutableURLRequest {
		let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: path)!)
		mutableURLRequest.HTTPMethod = method.rawValue
		
		switch self {
		case .Artist(_):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
		}
	}
}
