//
//  UIColor+HexString.h
//  RGB_triangle
//
//  Created by dRumyankov on 11/28/17.
//  Copyright © 2017 GFL. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN CGFloat const kUIColorChannelValueMax;

@interface UIColor (HexString)

- (NSString *)hexString;

@end
