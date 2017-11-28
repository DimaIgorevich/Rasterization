//
//  UIColor+ColorFromBaricentric.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import "UIColor+ColorFromBaricentric.h"

@implementation UIColor (ColorFromBaricentric)

+ (UIColor *)colorFromBaricentric:(Baricentric)baricentric {
    return [UIColor
            colorWithRed:kUIColorChannelValueMax * baricentric.lyambda_1 / kUIColorChannelValueMax
            green:kUIColorChannelValueMax * baricentric.lyambda_2 / kUIColorChannelValueMax
            blue:kUIColorChannelValueMax * baricentric.lyambda_3 / kUIColorChannelValueMax alpha:1.0f];
}

@end
