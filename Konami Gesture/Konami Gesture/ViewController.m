//
//  ViewController.m
//  Konami Gesture
//
//  Created by YASH on 26/10/15.
//  Copyright © 2015 YASH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void) konamiSuccessful:(GoKonami *) kGesture;

@end

@implementation ViewController

@synthesize konamiGestureRecognizer;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    konamiGestureRecognizer = [[GoKonami alloc] initWithTarget:self action:@selector(konamiSuccessful:)];
    [self.view addGestureRecognizer:konamiGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) konamiSuccessful:(GoKonami *)kGesture
{
    
    if (kGesture.state == UIGestureRecognizerStateRecognized)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"It works" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

@end
