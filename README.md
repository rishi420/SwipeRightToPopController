# SwipeRightToPopController
When user drags right (anywhere on the viewController), it pops the viewController

<p align="center"><img src="http://i.stack.imgur.com/mgNw0.gif"/></p>


To answer this question:

http://stackoverflow.com/q/35388985/1378447

**How can I implement "drag right to dismiss" a View Controller that's in a navigation stack?**

By default, if you drag right from the left edge of the screen, it will drag away the ViewController and take it off the stack.

I want to extend this functionality to the entire screen. When the user drags right anywhere, I'd like the same to happen.

I know that I can implement a swipe right gesture and simply call self.navigationController?.popViewControllerAnimated(true)

However, there is no "dragging" motion. I want the user to be able to right-drag the view controller as if it's an object, revealing what's underneath. And, if it's dragged past 50%, dismiss it. (Check out instagram to see what I mean.)
