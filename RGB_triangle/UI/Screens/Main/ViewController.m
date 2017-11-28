//
//  ViewController.m
//  RGB_triangle
//
//  Created by dRumyankov on 11/27/17.
//  Copyright © 2017 GFL. All rights reserved.
//  Растеризация треугольников на основе барицентрических координат

#import "ViewController.h"

CGFloat const kViewControllerCirclePointerWidth = 5.f;

@interface ViewController ()

@property (nonatomic) BCTriangle triangle;

@property (weak, nonatomic) IBOutlet UIView *vTriangle;

@property (weak, nonatomic) IBOutlet UILabel *lblColorHex;

@property (weak, nonatomic) IBOutlet UIView *vColorResult;

@property (strong, nonatomic) UIView *vPointer;

@end

@implementation ViewController

#pragma mark - Initialize

- (void)initTriangle {
    self.triangle = (BCTriangle){
        CGPointMake(0, CGRectGetHeight(self.vTriangle.frame)),
        CGPointMake(CGRectGetWidth(self.vTriangle.frame), CGRectGetHeight(self.vTriangle.frame)),
        CGPointMake(CGRectGetWidth(self.vTriangle.frame) / 2.f, 0)
    };
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addTriangle];
        [self addCirclePointer];
    });
}

#pragma mark - UI

- (void)addCirclePointer {
    self.vPointer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewControllerCirclePointerWidth, kViewControllerCirclePointerWidth)];
    self.vPointer.center = self.vTriangle.center;
    self.vPointer.backgroundColor = [UIColor whiteColor];
    self.vPointer.layer.cornerRadius = kViewControllerCirclePointerWidth / 2.f;
    [self.vTriangle addSubview:self.vPointer];
}

- (void)addTriangle {
    [self initTriangle];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:self.triangle.vertexLeft];
    [path addLineToPoint:self.triangle.vertexRight];
    [path addLineToPoint:self.triangle.vertexTop];
    [path addLineToPoint:self.triangle.vertexLeft];
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.vTriangle.bounds;
    mask.path = path.CGPath;
    [self.vTriangle.layer addSublayer:mask];
}

#pragma mark - Touch

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    CGPoint currentPos = [myTouch locationInView: self.view];
    if (CGRectContainsPoint(self.vTriangle.frame, currentPos)) {
        CGPoint touchPos = [myTouch locationInView:self.vTriangle];
        if ([BCTouchPointTriangleHelper isPoint:touchPos inTriangle:self.triangle]) {
            Baricentric baricentric = [BCBaricentricForTriangle baricentricForTriangle:self.triangle inPoint:touchPos];
            self.vColorResult.backgroundColor = [UIColor colorFromBaricentric:baricentric];
            self.lblColorHex.text = [self.vColorResult.backgroundColor hexString];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    CGPoint currentPos = [myTouch locationInView: self.view];
    if (CGRectContainsPoint(self.vTriangle.frame, currentPos)) {
        CGPoint touchPos = [myTouch locationInView:self.vTriangle];
        if ([BCTouchPointTriangleHelper isPoint:touchPos inTriangle:self.triangle]) {
            Baricentric baricentric = [BCBaricentricForTriangle baricentricForTriangle:self.triangle inPoint:touchPos];
            self.vColorResult.backgroundColor = [UIColor colorFromBaricentric:baricentric];
            self.lblColorHex.text = [self.vColorResult.backgroundColor hexString];
        }
    }
}

@end
