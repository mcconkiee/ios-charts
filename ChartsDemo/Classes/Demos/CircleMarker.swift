//
//  CircleMarker.swift
//  ChartsDemo
//
//  Created by Eric McConkie on 6/5/15.
//  Copyright (c) 2015 dcg. All rights reserved.
//

import UIKit
import Charts
public class CircleMarker: ChartMarker {
    public var fillColor: UIColor!;
    public var ringColor: UIColor!;
    public var insets: UIEdgeInsets!;
    public var minimumSize = CGSize();
    private var _size: CGSize!{
        get{
            return minimumSize
        }
    }
    public init(fillColor: UIColor,ringColor:UIColor,  insets: UIEdgeInsets)
    {
        super.init();
        
        self.fillColor = fillColor;
        self.ringColor = ringColor;
        self.insets = insets;
        
    }
    
    public override var size: CGSize { return _size; }
    
    public override func draw(#context: CGContext, point: CGPoint)
    {
        CGContextSaveGState(context);
        var fillrect = CGRect(origin: point, size: CGSizeMake(_size.width / 2, _size.height / 2));
        fillrect.origin.x -= _size.width  / 4;
        fillrect.origin.y -= _size.height / 4;
        
        var ringrect = CGRect(origin: point, size: CGSizeMake(_size.width , _size.height))
        ringrect.origin.x -= _size.width / 2.0;
        ringrect.origin.y -= _size.height / 2.0;
        
        var outter = CGPathCreateMutable()
        CGPathMoveToPoint(outter!, nil, point.x,point.y)
        CGPathAddEllipseInRect(outter, nil, ringrect)
        CGPathCloseSubpath(outter)
        CGContextAddPath(context, outter)

        
        var inner = CGPathCreateMutable()
        CGPathMoveToPoint(inner!, nil, point.x,point.y)
        CGPathAddEllipseInRect(inner, nil, fillrect)
        CGPathCloseSubpath(inner)
        CGContextAddPath(context, inner)
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextEOFillPath(context)
        CGContextRestoreGState(context);
        
    }
    
    public override func refreshContent(#entry: ChartDataEntry, dataSetIndex: Int)
    {
        var label = entry.value.description;
        println("label value for marker \r\n \(label)")
    }

}
