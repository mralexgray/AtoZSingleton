

#import <Cocoa/Cocoa.h>
#import <SenTestingKit/SenTestingKit.h>
#import "AtoZSingleton.h"

#define IMPLEMENT(NAME,CLASS) @interface NAME : CLASS @end @implementation NAME @end


@interface             IBSingletonTests : SenTestCase
- (void) testIBSingleton;
@end
@interface             AZSingletonTests : SenTestCase
@property id x, y, z, a, b, c;
- (void) testSubclassing;
- (void) testIsInitialized;
- (void) testUnique;
- (void) testInstantiation;
@end

@interface                  IBSingleton : AtoZIBSingleton                   @end
@interface             IBSingletonOwner : NSViewController
@property (assign) IBOutlet IBSingleton * ib;                               @end
                              IMPLEMENT   (FooSingleton,AtoZSingleton)
                              IMPLEMENT   (BarSingleton,AtoZSingleton)

@implementation             IBSingleton - (void) awakeFromNib    { NSLog(@"rise from my grave:%@", NSStringFromClass(self.class)); }      @end
@implementation        IBSingletonOwner
//- (void) awakeFromNib    { [super awakeFromNib]; NSLog(@"ride from my grave:%@", _ib); }
@end
@implementation        IBSingletonTests - (void) testIBSingleton {	IBSingletonOwner *n;  	IBSingleton __weak *s = IBSingleton.new;

	[n = [IBSingletonOwner.alloc initWithNibName:@"IBSingletonOwner" bundle:[NSBundle bundleForClass:self.class]] loadView];

	STAssertNotNil	(n,	@"Owner must not be nil");
	STAssertNotNil	([n ib],	@"Owner's singleton must not be nil");
	STAssertEquals	(s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");
	n.ib = nil;
	STAssertNil    (n.ib ,	@"Setting IBoutlet Singleton to nil should work.");
	STAssertNotNil (s,		@"Pointer to singleton should now also be nil.");
	n.ib = IBSingleton.shared;
	STAssertEquals(s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");
}      @end
@implementation        AZSingletonTests

- (void) testInstantiation	{

	STAssertNotNil			(_x = AtoZSingleton.shared,	@"Object must not be nil");
	STAssertNotNil			(_y = AtoZSingleton.new, 				  	@"Object must not be nil");
	STAssertNotNil			(_z = AtoZSingleton.alloc.init,		  	@"Object must not be nil");
	STAssertEqualObjects(_x,_y, @"no matter how you slice it, they should be the same.");
	STAssertEqualObjects(_y,_z, @"no matter how you slice it, they should be the same.");
	STAssertEqualObjects(_z,_x, @"no matter how you slice it, they should be the same.");
}
- (void) testUnique         {
	AtoZSingleton *s1 = AtoZSingleton.shared,
					  *s2 = AtoZSingleton.shared;
	
	STAssertEqualObjects	(s1, s2, @"Objects must be equal");
	
	AtoZSingleton *s3 = AtoZSingleton.new;

	STAssertEqualObjects	(s1, s3, @"Objects must be equal");
}
- (void) testIsInitialized  {

	AtoZSingleton *s = AtoZSingleton.shared;
	STAssertTrue			(s.inited, @"Singleton must be initialized");
}
- (void) testSubclassing    {

	FooSingleton *foo = FooSingleton.shared;
	BarSingleton *bar = BarSingleton.shared;
	
	STAssertNotNil (foo, @"Object must not be nil");
	STAssertNotNil (bar, @"Object must not be nil");
	
	STAssertTrue   ([foo isKindOfClass:FooSingleton.class], @"");
	STAssertTrue   ([bar isKindOfClass:BarSingleton.class], @"");
//	STAssertFalse  (foo == bar, @"Objects must not be equal!");

	FooSingleton *foo2 = FooSingleton.new;
	STAssertEqualObjects (foo, foo2, @"Objects must be equal");
}

@end
