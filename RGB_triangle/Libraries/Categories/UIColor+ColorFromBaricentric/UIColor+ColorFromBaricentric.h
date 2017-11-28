//
//  UIColor+ColorFromBaricentric.h
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat lyambda_1;
    CGFloat lyambda_2;
    CGFloat lyambda_3;
}Baricentric;

@interface UIColor (ColorFromBaricentric)

+ (UIColor *)colorFromBaricentric:(Baricentric)baricentric;

@end
