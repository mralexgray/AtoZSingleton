# AtoZSingleton [![Build Status](https://travis-ci.org/mralexgray/AtoZSingleton.png?branch=master)](https://travis-ci.org/mralexgray/AtoZSingleton)

`AtoZSingleton` is a subclassable Objective-C singleton for Mac OSX and iOS.

## Ussage

### Copy files

Copy the following files to your project:

* `AtoZSingleton/AtoZSingleton.h`
* `AtoZSingleton/AtoZSingleton.m`

<del>`AtoZSingleton` is also available on [CocoaPods](http://cocoapods.org/?q=AtoZSingleton)</del>

### Subclass

`AtoZSingleton` is designed for subclassing, you should subclass it to make your own singleton:

``` objective-c
#import "AtoZSingleton.h"

@interface MySingleton : AtoZSingleton {
	NSString *foo;
}

- (void)printFoo;	

@end
```

When subclassing `AtoZSingleton` you should think about your subclass as an ordinary class, `AtoZSingleton` makes sure that there is only one instance of your class.
 
If you want to make your own initializer or override `-init` method your should check whether your singleton has already been initialized with `isInitialized` property to prevent repeated initialization.


``` objective-c
#import "MySingleton.h"
	
@implementation MySingleton
	
- (id)init
{
	self = [super init];
	if (self && !self.isInitialized) {
		foo = @"Foo";
	}
	return self;
}
	
- (void)printFoo
{
	NSLog(@"%@", foo);
}
	
@end
```

Then you can get the shared instance of your singleton with `+sharedInstance` methods:

``` objective-c
[[MySingleton sharedInstance] printFoo];
```

## Requirements

`AtoZSingleton` uses ARC.

## Documentation

http://cocoadocs.org/docsets/AtoZSingleton

## License

AtoZSingleton is available under the MIT license. See the [LICENSE.md](LICENSE.md) file for more info.

Feel free to use it and contribute!


coveralls.rb ??