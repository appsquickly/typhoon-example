//
//  DVParallaxView.h
//  ParallaxViewTest
//
//  Created by Mikhail Grushin on 11.07.13.
//  Copyright (c) 2013 DENIVIP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVParallaxView : UIView

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic) float parallaxDistanceFactor;
@property (nonatomic) float parallaxFrontFactor;
@property (nonatomic) CGPoint contentOffset;

@property (nonatomic) BOOL gyroscopeControl;
@property (nonatomic) BOOL boundContentsToScreen;

@end
