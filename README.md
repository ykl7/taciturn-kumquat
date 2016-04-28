# taciturn-kumquat

This is an attempt to make a simple library for the famous Konami gesture.

To add to any view in a project, import the GoKonami files and to the view in which it has to be implemented, add the following code:

```objective-c
import "GoKonami.h"

- (void) initKonami
{

	konamiGestureRecognizer = [[GoKonami alloc] initWithTarget:self action:@selector(konamiSuccessful:)];
    [self.view addGestureRecognizer:konamiGestureRecognizer];

}

- (void) konamiSuccessful:(GoKonami *)kGesture
{
	if (kGesture.state == UIGestureRecognizerStateRecognized)
    {
        
        // your code here
        
    }
    
}
```

Please feel free to contribute and attempt to make the gestures work, and do send a Pull Request.