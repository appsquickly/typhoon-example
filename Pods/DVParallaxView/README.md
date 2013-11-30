DVParallaxView
==============

DVParallaxView is a subclass of UIView that applies parallax effect on all its subviews. You can turn on the gyroscope control and use it to make parallax like at home screen of iOS 7. You can add views to parallax scene by simply adding them to DVParallaxView subviews. Move views with parallax by simply changing the contentOffset property or tilting the device if the gyro is on. The place of view in subviews hierarchy is simultaneously it's depth in parallax scene. So when you change contentOffset each view moves on distance defined by it's index in subviews array.
DVParallaxView is very easy to use. Just plug it to your project, create an instance, add subviews and move it as you want by setting the contentOffset or by changing your phone's orientation. Our parallax view will do all the rest.
You can read about the concepts of making parallax in this component in our article - http://blog.denivip.ru/index.php/2013/08/parallax-in-ios-applications/?lang=en.

##Required Frameworks##
  - Core Motion

##Adding DVParallaxView to your project##
You have to common ways to use our component in your project
###CocoaPods###
Our project uses CocoaPods. To plug it to your project you need to create Podfile and add following lines to it:

`platform :ios, '6.1' //whatever version you want, but >=5.0`
`pod 'DVParallaxView', :git=>'https://github.com/denivip/DVParallaxView'`

Then run `pod install` from your console and it will do all the magic. Just don't forget to use workspace from now!

###Source files###
Just clone this repository or download it in zip-file. Then you will find source files under DVParallaxView directory. All you need is to copy them to your project.

##Usage##
###Create an instance###
`DVParallaxView *parallaxView = [DVParallaxView alloc] init];`

###Adding views to parallax###
Just call the addSubview: method.
`[parallaxView addSubview:view];`

Each added subview will take it's place at parallax scene and will move in parallax with the speed defined by it's position. If you want some views to change it's position at the equal speed you have to add them to one UIView container first, and then add this container to parallax view.

###Set the Background image###
You can easily set the background image by calling setBackgroundImage: method. 
`[parallaxView setBackgroundImage:image];`
After calling this method background image will appear in parallax view. Independently of the current subviews it will be on the first place of subviews array, thus it will appear behind all views. Also it will have the slowest parallax velocity among all the views.
Notice that if the background is set parallax will change views coordinates only until the background images come to it's edge. Parallax won't move in that direction any further. If background image isn't set - parallax is infinite.

###Moving subviews (making parallax)###
To apply an offset with parallax to subviews you must change the contentOffset property value.
`CGPoint newOffset = CGPointMake(50.f, 50.f);
[parallaxView setContentOffset:newOffset];`

It will change the center point of all views to the distance defined by view's position in subviews hierarchy. You can specify the distance between views on different levels, i.e. the multiplier for offset of every view.
`[parallaxView setParallaxDistanceFactor:4.f];`

###Set the Front view###
You can set the Front view of parallax view. View that will be at the front will move in opposite direction to all other views, thus increasing the contrast between the parallax moving views and opposite moving frontal view.
`[parallaxView setFrontView:frontView];`

It can be used to make a parallax effect made at homescreen in iOS 7, when space background view moves in one way and icons moves opposite to it.
You can also set the multiplier for front view as for other views.
`[parallaxView setParallaxFrontFactor:20.f];`

###Gyroscope control###
You can enable or disable gyroscope control with the gyroscopeControl property.
`[parallaxView setGyroscopeControl:YES];`

##Requirements##
DVParallaxView requires iOS 5.0 or higher and ARC.
