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

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([[event touchesForGestureRecognizer:self] count] > 1)
    {
        
        [self setState:UIGestureRecognizerStateFailed];
        
    }
    
    else
    {
        
        if (self.presentGesture == UIGestureRecognizerStateChanged)
        {
            
            if (self.presentGesture < RightGesture2)
            {
                
                NSDate *presentTimeStamp = [NSDate date];
                if ([presentTimeStamp timeIntervalSinceDate:self.timeOfPreviousGesture] > betweenGestures)
                {
                    
                    self.presentGesture = NoGesture;
                    
                }
                
            }
            
        }
        
        else if (self.state == UIGestureRecognizerStatePossible)
        {
            
            [self setState:UIGestureRecognizerStateBegan];
            self.presentGesture = NoGesture;
            
        }
        
        else
        {
            
            [self setState:UIGestureRecognizerStateFailed];
            return;
            
        }
        
        self.timeOfPreviousGesture = [NSDate new];
        UITouch *presentTouch = [touches anyObject];
        self.previousGestureStartPosition = [presentTouch locationInView:self.view];
        
    }
    
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (self.presentGesture > RightGesture2)
    {
        
        return;
        
    }
    
    NSDate *presentTimeStamp = [NSDate new];
    if ([presentTimeStamp timeIntervalSinceDate:self.timeOfPreviousGesture] > duringGesture)
    {
        
        [self setState:UIGestureRecognizerStateFailed];
        return;
        
    }
    
    BOOL checkXCoord = NO;
    BOOL checkYCoord = NO;
    
    progressInGesture(self.presentGesture + 1, &checkXCoord, &checkYCoord);
    
    if ((checkXCoord == YES) || (checkYCoord == YES))
    {
        
        BOOL nullifyGesture = NO;
        UITouch *presentTouch = [touches anyObject];
        CGPoint presentTouchAt = [presentTouch locationInView:self.view];
        
        if (checkXCoord == YES)
        {
            
            CGFloat distanceCoveredInTouchX = fabs(presentTouchAt.x - self.previousGestureStartPosition.x);
            if (distanceCoveredInTouchX > tolerateSwipe)
            {
                
                nullifyGesture = YES;
                
            }
            
        }
        
        else
        {
            
            CGFloat distanceCoveredInTouchY = fabs(presentTouchAt.y - self.previousGestureStartPosition.y);
            if (distanceCoveredInTouchY > tolerateSwipe)
            {
                
                nullifyGesture = YES;
                
            }
            
        }
        
        if (nullifyGesture)
        {
            
            [self setState:UIGestureRecognizerStateFailed];
            
        }
        
    }
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (self.presentGesture >= RightGesture2)
    {
        
        return;
        
    }
    
    if (self.state != UIGestureRecognizerStateChanged)
    {
        
        [self setState:UIGestureRecognizerStateFailed];
        return;
        
    }
    
    BOOL checkPosYState = NO;
    BOOL checkNegYState = NO;
    BOOL checkPosXState = NO;
    BOOL checkNegXState = NO;
    
    progressInGestureSeries(self.presentGesture + 1, &checkNegXState, &checkPosXState, &checkPosYState, &checkNegYState);
    
    if (checkNegYState || checkNegXState || checkPosXState || checkPosYState)
    {
        
        BOOL nullifyGesture = NO;
        UITouch *presentTouch = [touches anyObject];
        CGPoint presentTouchAt = [presentTouch locationInView:self.view];
        
        if (checkPosXState || checkNegXState)
        {
            
            CGFloat distanceCoveredInTouchX = presentTouchAt.x - self.previousGestureStartPosition.x;
            if ((checkNegXState) && (distanceCoveredInTouchX <  -1 * minSwipeLength))
            {
                
            }
            
            else if ((checkPosXState) &&(distanceCoveredInTouchX > minSwipeLength))
            {
                
            }
            
            else
            {
                
                nullifyGesture = YES;
                
            }
            
        }
        
        else
        {
            
            CGFloat distanceCoveredInTouchY = presentTouchAt.y - self.previousGestureStartPosition.y;
            if ((checkNegYState) && (distanceCoveredInTouchY < -1 * minSwipeLength))
            {
                
            }
            
            else if ((checkPosYState) && (distanceCoveredInTouchY > minSwipeLength))
            {
                
            }
            
            else
            {
                
                nullifyGesture = YES;
                
            }
            
        }
        
        if (nullifyGesture)
        {
            
            [self setState:UIGestureRecognizerStateFailed];
            return;
            
        }
        
    }
    
    self.presentGesture = self.presentGesture + 1;
    self.timeOfPreviousGesture = [NSDate new];
    
    [self setState:UIGestureRecognizerStateChanged];
    
    if (self.presentGesture >= RightGesture2)
    {
        
        self.presentGesture = FinalGesture;
        [self setState:UIGestureRecognizerStateRecognized];
        
    }
    
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self setState:UIGestureRecognizerStateFailed];
    
}

void progressInGestureSeries (KonamiGestures presentGesture, BOOL *progressInNegXCoord, BOOL *progressInPosXCoord, BOOL *progressInPosYCoord, BOOL *progressInNegYCoord)
{
    
    switch (presentGesture)
    {
            
        case NoGesture:
        case UpGesture1:
        case UpGesture2:
            *progressInPosYCoord = YES;
            break;
        case DownGesture1:
        case DownGesture2:
            *progressInNegYCoord = YES;
            break;
        case LeftGesture1:
        case LeftGesture2:
            *progressInNegXCoord = YES;
            break;
        case RightGesture1:
        case RightGesture2:
            *progressInPosXCoord = YES;
            break;
        case VoidGesture:
        case FinalGesture:
        default:
            break;
            
    }
    
}

void progressInGesture (KonamiGestures presentGesture, BOOL *progressInXCoord, BOOL *progressInYCoord)
{
    
    switch (presentGesture)
    {
            
        case NoGesture:
        case UpGesture1:
        case UpGesture2:
        case DownGesture1:
        case DownGesture2:
            *progressInXCoord = YES;
            break;
        case LeftGesture1:
        case RightGesture1:
        case LeftGesture2:
        case RightGesture2:
            *progressInYCoord = YES;
            break;
        case  VoidGesture:
        case FinalGesture:
        default:
            break;
    }
    
}
@end
