//
//  KonamiGestureRecognizer.h
//  Konami Gesture
//
//  Created by YASH on 26/10/15.
//  Copyright © 2015 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoKonami;
@protocol GoKonamiProtocol <NSObject>

@required

@end

typedef NS_ENUM(NSInteger, KonamiGestures)

{NoGesture, UpGesture1, UpGesture2, DownGesture1, DownGesture2, LeftGesture1, RightGesture1, LeftGesture2, RightGesture2};

@interface KonamiGestureRecognizer : UIGestureRecognizer

@property (readonly, nonatomic) KonamiGestures whereIsKonami;

@end
