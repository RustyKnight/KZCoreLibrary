//
//  NumberExtensions.swift
//  KZCoreLibrary
//
//  Created by Shane Whitehead on 26/03/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

import Foundation

//----- Core numerical extensions -----//

public extension Float {
	public var toRadians : Float {
		return self * Float(Double.pi) / 180.0
	}
	public var toDegrees: Float {
		return self * 180 / Float(Double.pi)
	}
	public var toDouble: Double {
		return Double(self)
	}
}

public extension Double {
	public var toRadians : Double {
		return self * Double.pi / 180.0
	}
	
	public var toDegrees: Double {
		return self * 180 / Double.pi
	}
	
	public var toFloat: Float {
		return Float(self)
	}
}
