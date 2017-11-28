//
//  BCTouchPointTriangleHelper.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import "BCTouchPointTriangleHelper.h"

@implementation BCTouchPointTriangleHelper

+ (BOOL)isPoint:(CGPoint)touchPoint inTriangle:(BCTriangle)triangle {
    BOOL b1;
    BOOL b2;
    BOOL b3;
    
    b1 = sign(touchPoint, triangle.vertexLeft, triangle.vertexRight) < 0.0f;
    b2 = sign(touchPoint, triangle.vertexRight, triangle.vertexTop) < 0.0f;
    b3 = sign(touchPoint, triangle.vertexTop, triangle.vertexLeft) < 0.0f;
    
    return ((b1 == b2) && (b2 == b3));
}

float sign (CGPoint p1, CGPoint p2, CGPoint p3) {
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

@end
