
#import "AtoZSingleton.h"

@implementation AtoZIBSingleton

+ (instancetype) shared                   {   __strong static id _sharedI = nil; static dispatch_once_t uno;

  dispatch_once(&uno, ^{ _sharedI = [[self _alloc] _init]; }); return _sharedI;

}
+           (id) allocWithZone:(NSZone*)z { return [self shared];               }
+           (id) alloc                    { return [self shared];               }
-           (id) init                     { return  self;                       }
-           (id)_init                     { return [super init];                }
+           (id)_alloc                    { return [super allocWithZone:NULL];  }

@end

@implementation AtoZSingleton static NSMutableDictionary *sharedInfo_; // Dictionary holds all instances of AZSingleton subclasses

+ (void)    initialize              { sharedInfo_ = sharedInfo_ ?: NSMutableDictionary.new; }

+   (id) allocWithZone:(NSZone*)z   { return self.shared; } // Prevent allocating memory in a different zone
+   (id)  copyWithZone: (NSZone*)z  { return self.shared; } // Disallow copying to a different zone

#pragma mark - Instances

+ (instancetype)   shared { id shared = nil; /* If there's no instance – create one and add it to the dictionary */
	
	@synchronized(self) {	shared = sharedInfo_[NSStringFromClass(self)] =
                                 sharedInfo_[NSStringFromClass(self)] ?: [super allocWithZone:nil].init;	}
	return shared;
}
+ (instancetype) instance { return self.shared; 																			}

- (id)               init {	return self = super.init ? _inited = YES, self : nil; }
@end


// Copyright (c) 2013 Dmitry Obukhov (stel2k@gmail.com)

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
