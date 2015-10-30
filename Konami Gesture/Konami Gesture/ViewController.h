//
//  ViewController.h
//  Konami Gesture
//
//  Created by YASH on 26/10/15.
//  Copyright © 2015 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoKonami.h"

@interface ViewController : UIViewController <GoKonamiProtocol>

@property (nonatomic, readonly) GoKonami *konamiGestureRecognizer;

@end

