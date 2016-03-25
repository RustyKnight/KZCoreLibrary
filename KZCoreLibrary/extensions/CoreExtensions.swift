//
//  CoreExtensions.swift
//  KZCoreLibrary
//
//  Created by Shane Whitehead on 25/03/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

import Foundation

/************************************************************************/
// Basic conversions and mathamtic support

public extension Float {
	var toCGFloat: CGFloat {
		return CGFloat(self)
	}
	var toRadians : Float {
		return self * Float(M_PI) / 180.0
	}
	var toDegrees: Float {
		return self * 180 / Float(M_PI)
	}
	var toDouble: Double {
		return Double(self)
	}
}

public extension Double {
	var toCGFloat: CGFloat {
		return CGFloat(self)
	}
	var toRadians : Double {
		return self * M_PI / 180.0
	}
	var toDegrees: Double {
		return self * 180 / M_PI
	}
	var toFloat: Float {
		return Float(self)
	}
}

public extension CGFloat {
	var toRadians : CGFloat {
		return CGFloat(self) * CGFloat(M_PI) / 180.0
	}
	var toDegrees: CGFloat {
		return self * 180 / CGFloat(M_PI)
	}
	var toDouble: Double {
		return Double(self)
	}
	var toFloat: Float {
		return Float(self)
	}
}

/************************************************************************/
