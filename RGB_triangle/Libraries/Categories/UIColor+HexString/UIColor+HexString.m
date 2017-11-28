//
//  UIColor+HexString.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import "UIColor+HexString.h"

CGFloat const kUIColorChannelValueMax = 255.f;

@implementation UIColor (HexString)

- (NSString *)hexString {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * kUIColorChannelValueMax),
            lroundf(g * kUIColorChannelValueMax),
            lroundf(b * kUIColorChannelValueMax)];
}

@end
