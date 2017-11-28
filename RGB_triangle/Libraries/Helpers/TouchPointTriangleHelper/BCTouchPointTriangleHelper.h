//
//  BCTouchPointTriangleHelper.h
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCTouchPointTriangleHelper : NSObject

+ (BOOL)isPoint:(CGPoint)touchPoint inTriangle:(BCTriangle)triangle;

@end
