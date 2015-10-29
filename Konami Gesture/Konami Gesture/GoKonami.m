//
//  GoKonami.m
//  Konami Gesture
//
//  Created by YASH on 29/10/15.
//  Copyright © 2015 YASH. All rights reserved.
//

#import "GoKonami.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static const CGFloat tolerateSwipe = 50.0f;
static const CGFloat minSwipeLength = 50.0f;
static const NSTimeInterval betweenGestures = 1.0f;
static const NSTimeInterval duringGesture = 1.0f;

void progressInGesture (KonamiGestures presentGesture, BOOL *progressInXCoord, BOOL *progressInYCoord);
void progressInGestureSeries (KonamiGestures presentGesture, BOOL *progressInNegXCoord, BOOL *progressInPosXCoord, BOOL *progressInPosYCoord, BOOL *progressInNegYCoord);

@interface GoKonami ()

@property (nonatomic, readwrite) KonamiGestures presentGesture;
@property (nonatomic, strong, readwrite) NSDate *timeOfPreviousGesture;
@property (nonatomic, readwrite) CGPoint previousGestureStartPosition;

@end

@implementation GoKonami

- (id) initWithTarget:(id)target action:(SEL)action
{
    
    self = [super initWithTarget:target action:action];
    if (!self)
    {
        
        self.presentGesture = NoGesture;
        self.timeOfPreviousGesture = [NSDate new];
        self.previousGestureStartPosition = CGPointZero;
        
    }
    
    return  self;
    
}

- (void) resetGestureSeriesToNone
{
    
    self.presentGesture = NoGesture;
    
}



@end
