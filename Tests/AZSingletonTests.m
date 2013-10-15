

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "AZSingleton.h"


@interface IBSingleton :  	AZIBSingleton @end  @implementation IBSingleton - (void)awakeFromNib { NSLog(@"rise from my grave:%@", NSStringFromClass([self class])); } 	@end
@interface IBSingletonOwner : NSViewController { __unsafe_unretained IBSingleton *_ib; }
@property (assign) IBOutlet IBSingleton *ib;
@end
@implementation IBSingletonOwner - (void)awakeFromNib { [super awakeFromNib]; NSLog(@"ride from my grave:%@", _ib); }
@end


@interface IBSingletonTests : XCTestCase @end @implementation IBSingletonTests

- (void) testIBSingleton {	IBSingletonOwner *n;  	IBSingleton __weak *s = IBSingleton.new;

	[n = [IBSingletonOwner.alloc initWithNibName:@"IBSingletonOwner" bundle:[NSBundle bundleForClass:self.class]] loadView];

	XCTAssertNotNil	(n,	@"Owner must not be nil");
	XCTAssertNotNil	([n ib],	@"Owner's singleton must not be nil");

	XCTAssertEqual		(s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");
	n.ib = nil;
	XCTAssertNil 	(n.ib ,	@"Setting IBoutlet Singleton to nil should work.");
	XCTAssertNotNil(s,		@"Pointer to singleton should now also be nil.");
	n.ib = IBSingleton.shared;
	XCTAssertEqual(s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");

	}
@end

@interface FooSingleton : AZSingleton @end  @implementation FooSingleton @end
@interface BarSingleton : AZSingleton @end  @implementation BarSingleton @end

@interface AZSingletonTests : XCTestCase
@property id x, y, z, a, b, c;			@end @implementation AZSingletonTests


- (void) testInstantiation	{

	XCTAssertNotNil			(_x = AZSingleton.shared,	@"Object must not be nil");
	XCTAssertNotNil			(_y = AZSingleton.new, 				  	@"Object must not be nil");
	XCTAssertNotNil			(_z = AZSingleton.alloc.init,		  	@"Object must not be nil");
	XCTAssertEqualObjects(_x,_y, @"no matter how you slice it, they should be the same.");
	XCTAssertEqualObjects(_y,_z, @"no matter how you slice it, they should be the same.");
	XCTAssertEqualObjects(_z,_x, @"no matter how you slice it, they should be the same.");
}
- (void)testUnique
{
	AZSingleton *s1 = AZSingleton.shared,
					*s2 = AZSingleton.shared;
	
	XCTAssertEqualObjects	(s1, s2, @"Objects must be equal");
	
	AZSingleton *s3 = AZSingleton.new;

	XCTAssertEqualObjects	(s1, s3, @"Objects must be equal");
}
- (void)testIsInitialized
{
	AZSingleton *s = AZSingleton.shared;
	XCTAssertTrue			(s.inited, @"Singleton must be initialized");
}

- (void)testSubclassing
{
	FooSingleton *foo = FooSingleton.shared;
	BarSingleton *bar = BarSingleton.shared;
	
	XCTAssertNotNil 		(foo, @"Object must not be nil");
	XCTAssertNotNil 		(bar, @"Object must not be nil");
	
	XCTAssertTrue   		([foo isKindOfClass:FooSingleton.class], @"");
	XCTAssertTrue   		([bar isKindOfClass:BarSingleton.class], @"");
	XCTAssertNotEqual		(foo, bar, @"Objects must not be equal");
	
	FooSingleton *foo2 = FooSingleton.new;
	XCTAssertEqualObjects (foo, foo2, @"Objects must be equal");
}

@end
