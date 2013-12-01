MKParallaxView
==============

MKParallaxView is an easy to use framework used to create the IOS 7 Parallax Effect (Dynamic Background) on any of your apps! 

Treat it just like a UIImageView and by simply assigning an image to it with 1 line you have the exact same effect for the background of your app.

MKParallaxView is now a CocoaPod! so jump to http://cocoapods.org/ to get it that way :)

Important note: this framework uses the device's gyro, so it will look just like a normal background in simulators. Try the demo on a device instead!

To start go to <b>Project</b> -> <b>Target</b> -> <b>Build Phases</b> -> <b>Link Binary With Libraries</b> and add <b>CoreMotion.framework</b>

In the view or view controller (or prefix):

<code>#import "MKParallaxView.h"</code>

To create the parallax view with a <b>basic</b> background image do the following:

<code>MKParallaxView *basicBackground = [[MKParallaxView alloc] initWithFrame:self.frame];</code>
<code>basicBackground.backgroundImage = [UIImage imageNamed:@"backgroundImage.png"];</code>

To create the parallax view with a <b>repeat</b> background image do the following:

<code>MKParallaxView *repeatBackgound = [[MKParallaxView alloc] initWithFrame:self.frame];</code>
<code>repeatBackgound.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundRepeatableImage.png"]];</code>

The animation defaults at 60 frames per second (fps) which is really smooth, but if you want to bring it down to say 30 fps, just do the following on each MKParallaxView you have:

<code>basicBackground.updateRate = 30;</code>

I hope you enjoy this framework. Please <b>star</b> it above; and if your iTunes app uses it, please <b>add it to the list</b> on the wiki along with an iTunes link.

Thank you,

Kind Regards

Morgan Kennedy

p.s. If you want you can utilize the MKGyroManager as is:

MKGyroManager
==============

If you want to use the "roll" "pitch" "yaw" values that the gyro manager (singleton) spits out 60 times a second anywhere else in your app you can by doing the following:

<code>#import "MKGyroManager.h"</code><br />
<code>@interface MyViewController ()< MKGyroManagerDelegate ></code><br />
<code>[MKGyroManager sharedGyroManager].delegate = self;</code><br />
<code>- (void)MKGyroManagerUpdatedRoll:(CGFloat)roll Pitch:(CGFloat)pitch Yaw:(CGFloat)yaw</code><br />

There's also a NSNotification that you can listen to if you prefer with the values in the <code>notification.userInfo</code><br />
<code>MKGyroManagerUpdateAnglesNotification</code>

Or you can just observe the latestValue of a specific attribute like so:<br />
<code>CGFloat roll = [[MKGyroManager sharedGyroManager] roll];</code>
