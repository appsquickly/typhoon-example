## PPiFlatSegmentedControl for iOS

PPiFlatSegmentedControl is an UI Control developed avoiding original UISegmentedControl to get interesting features related with the flat design. 
For better appearance you can add Font Awesome library to your project and use their icons into the Segmented Control

[Font Awesome Icons](http://fortawesome.github.io/Font-Awesome/icons/)

## Installation
Installation can be made easilly thanks to Pod in this repository. The only thing you have to do is add PPiFlatSegmentedControl in your Podfile

(If you haven't used CocoaPods before, you'll find more information [here](http://cocoapods.org/))

pod 'PPiFlatSegmentedControl', :git => 'https://github.com/pepibumur/PPiFlatSegmentedControl.git'

## How to use
To start using PPiFlatSC you have to import the class wherever you want to use:
```#import "PPiFlatSegmentedControl.h"```

And then instantiate it in your view:
```
PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 20, 250, 30) items:@[               @{@"text":@"Face",@"icon":@"icon-facebook"},
                                        @{@"text":@"Linkedin",@"icon":@"icon-linkedin"},
                                        @{@"text":@"Twitter",@"icon":@"icon-twitter"}
                                        ]
                                        iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                            
                                        }];
    segmented.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented.borderWidth=0.5;
    segmented.borderColor=[UIColor darkGrayColor];
    segmented.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];

```
### Properties
The parameters you are able to modify are the following:
* **color**: Background color of full segmentControl
* **selectedColor**: Background color for segment in selected state
* **borderWith**: Width of the border line around segments and control
* **borderColor**: Color "" ""
* **textAttributes**: Text attributes for non selected state
* **selectedTextAttributes**: Text attributes for selected state 

( If you have doubts you should consult more information in Apple Documentation or https://github.com/pepibumur/PPiAwesomeButton )


*Note: When you initialize the control you have to pass a Block with the behaviour when any segment has been selected*

#### Important Extra: Awesome Icons
The examples shown use FontAwesome library, you can add to your project using its Pod. Remember to add this font into your App Info.plist. Edit your app's Info.plist to contain the key:
                    "Fonts provided by application" (UIAppFonts).

                    <key>UIAppFonts</key>
                    <array>
                        <string>fontawesome-webfont.ttf</string>
                    </array>
 

## Screenshots
![image](http://img202.imageshack.us/img202/5927/faws.png)

## Changelogs 1.3.3
* **Important** : Initialize method has changed, please review the example before to see how FlatSegmented is now initialized
* PPiAwesomeButton: Now the control is linked with PPiAwesomeButton for more features
* IconPosition: Set Icon position respect the text


## License
PPiFlatSegmentedControl is available under the MIT license. See the LICENSE file for more info.
