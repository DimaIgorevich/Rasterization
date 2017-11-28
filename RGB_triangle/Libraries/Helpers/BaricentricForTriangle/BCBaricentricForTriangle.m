//
//  BCBaricentricForTriangle.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import "BCBaricentricForTriangle.h"

@implementation BCBaricentricForTriangle

+ (Baricentric)baricentricForTriangle:(BCTriangle)triangle inPoint:(CGPoint)point {
    CGFloat lyambda1 =
    ((triangle.vertexRight.y - triangle.vertexTop.y)*(point.x - triangle.vertexTop.x) + (triangle.vertexTop.x - triangle.vertexRight.x) * (point.y - triangle.vertexTop.y)) /
    ((triangle.vertexRight.y - triangle.vertexTop.y) * (triangle.vertexLeft.x - triangle.vertexTop.x) + (triangle.vertexTop.x - triangle.vertexRight.x) * (triangle.vertexLeft.y - triangle.vertexTop.y));
    
    CGFloat lyambda2 =
    ((triangle.vertexTop.y - triangle.vertexLeft.y) * (point.x - triangle.vertexTop.x) + (triangle.vertexLeft.x - triangle.vertexTop.x) * (point.y - triangle.vertexTop.y)) /
    ((triangle.vertexRight.y - triangle.vertexTop.y) * (triangle.vertexLeft.x - triangle.vertexTop.x) + (triangle.vertexTop.x - triangle.vertexRight.x) * (triangle.vertexLeft.y - triangle.vertexTop.y));
    
    CGFloat lyambda3 = 1 - lyambda1 - lyambda2;
    
    return (Baricentric){lyambda1, lyambda2, lyambda3};
}

@end
