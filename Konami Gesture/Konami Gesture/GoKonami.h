//
//  GoKonami.h
//  Konami Gesture
//
//  Created by YASH on 29/10/15.
//  Copyright © 2015 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoKonami;
@protocol GoKonamiProtocol <NSObject>
@end

typedef NS_ENUM(NSInteger, KonamiGestures)
{ VoidGesture = 0, NoGesture, UpGesture1, UpGesture2, DownGesture1, DownGesture2, LeftGesture1, RightGesture1, LeftGesture2, RightGesture2, FinalGesture };

@interface GoKonami : UIGestureRecognizer

@property (nonatomic, readonly) KonamiGestures whereIsKonami;

@end
