//
//  FlarePIX.swift
//  Pixels
//
//  Created by Anton Heestand on 2019-03-25.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Foundation

public class FlarePIX: PIXSingleEffect {
    
    override open var shader: String { return "effectSingleFlarePIX" }
    
    override var shaderNeedsAspect: Bool { return true }
    
    // MARK: - Public Properties
    
    public var scale: LiveFloat = 0.5
    public var count: LiveInt = 6
    public var angle: LiveFloat = 0.25
    public var threshold: LiveFloat = 0.9
    public var brightness: LiveFloat = 1.0
    public var gamma: LiveFloat = 0.25
    public var color: LiveColor = .orange
    public var rayRes: LiveInt = 32
    
    // MARK: - Property Helpers
    
    override var liveValues: [LiveValue] {
        return [scale, count, angle, threshold, brightness, gamma, color, rayRes]
    }
    
}