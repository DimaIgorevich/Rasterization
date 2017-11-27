//
//  ViewController.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/27/17.
//  Copyright © 2017 GFL. All rights reserved.
//  Растеризация треугольников на основе барицентрических координат

#import "ViewController.h"

static CGPoint V1;
static CGPoint V2;
static CGPoint V3;

CGFloat const colorR = 255.f;
CGFloat const colorG = 255.f;
CGFloat const colorB = 255.f;

typedef struct {
    CGFloat L1;
    CGFloat L2;
    CGFloat L3;
}BaricentricColor;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *vTriangle;

@property (weak, nonatomic) IBOutlet UIView *vColorResult;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initPoints];
        [self addTriangle];
    });
}

#pragma mark - Helpers

- (void)initPoints {
    V1 = CGPointMake(0, CGRectGetHeight(self.vTriangle.frame));
    V2 = CGPointMake(CGRectGetWidth(self.vTriangle.frame), CGRectGetHeight(self.vTriangle.frame));
    V3 = CGPointMake(CGRectGetWidth(self.vTriangle.frame) / 2.f, 0);
}

- (BOOL)isPoint:(CGPoint)touchPoint inTriangle:(CGPoint)v1 v2:(CGPoint)v2 v3:(CGPoint)v3 {
    BOOL b1;
    BOOL b2;
    BOOL b3;
    
    b1 = sign(touchPoint, v1, v2) < 0.0f;
    b2 = sign(touchPoint, v2, v3) < 0.0f;
    b3 = sign(touchPoint, v3, v1) < 0.0f;
    
    return ((b1 == b2) && (b2 == b3));
}

float sign (CGPoint p1, CGPoint p2, CGPoint p3) {
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

- (void)addTriangle {
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:V1];
    [path addLineToPoint:V2];
    [path addLineToPoint:V3];
    [path addLineToPoint:V1];
    
    
    
    // Create a CAShapeLayer with this triangular path
    // Same size as the original imageView
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.vTriangle.bounds;
    mask.path = path.CGPath;

    [self.vTriangle.layer addSublayer:mask];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    CGPoint currentPos = [myTouch locationInView: self.view];
    if (CGRectContainsPoint(self.vTriangle.frame, currentPos)) {
        CGPoint touchPos = [myTouch locationInView:self.vTriangle];
        if ([self isPoint:touchPos inTriangle:V1 v2:V2 v3:V3]) {
            NSLog(@"touchPos: x - %f y - %f", touchPos.x, touchPos.y);
            
            CGFloat l1 =
            ((V2.y - V3.y)*(touchPos.x - V3.x) + (V3.x - V2.x) * (touchPos.y - V3.y)) /
            ((V2.y - V3.y) * (V1.x - V3.x) + (V3.x - V2.x) * (V1.y - V3.y));
             
            CGFloat l2 =
            ((V3.y - V1.y) * (touchPos.x - V3.x) + (V1.x - V3.x) * (touchPos.y - V3.y)) /
            ((V2.y - V3.y) * (V1.x - V3.x) + (V3.x - V2.x) * (V1.y - V3.y));
             
            CGFloat l3 = 1 - l1 - l2;
            
            BaricentricColor color = {l1, l2, l3};
            self.vColorResult.backgroundColor = [self baricentricColor:color];
        }
    }
}

- (UIColor *)baricentricColor:(BaricentricColor)color {
    return [UIColor colorWithRed: colorR * color.L1 / colorR green: colorG * color.L2 / colorG blue: colorB * color.L3 / colorB alpha:1.0f];
}

@end
