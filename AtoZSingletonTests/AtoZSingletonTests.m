#import <objc/message.h>
#import <Cocoa/Cocoa.h>
#import <SenTestingKit/SenTestingKit.h>
#import "AtoZSingleton.h"

#define CLOG(X...) printf("\033[fg200,122,233;%s\033[fg20,184,111; %s\033[;\n",__PRETTY_FUNCTION__,[NSString stringWithFormat:X,nil].UTF8String)

@interface           IBSingleton : AtoZIBSingleton                                                  @end
@implementation      IBSingleton - (void) awakeFromNib { CLOG(@"whoppee!"); }                       @end
@interface      IBSingletonOwner : NSViewController @property (assign) IBOutlet IBSingleton * ib;   @end
@implementation IBSingletonOwner                                                                    @end
@interface      IBSingletonTests : SenTestCase                                                      @end
@implementation IBSingletonTests

- (void) testIBSingleton {	IBSingletonOwner *n;  	IBSingleton __weak *s = IBSingleton.new;

	[n = [IBSingletonOwner.alloc initWithNibName:@"IBSingletonOwner" bundle:[NSBundle bundleForClass:self.class]] loadView];

	STAssertNotNil	(n,       @"Owner must not be nil");
	STAssertNotNil	([n ib],	@"Owner's singleton must not be nil");
	STAssertEquals	(s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");     n.ib = nil;
	STAssertNil     (n.ib,    @"Setting IBoutlet Singleton to nil should work.");
	STAssertNotNil  (s,       @"Pointer to singleton should now also be nil.");                   n.ib = IBSingleton.shared;
	STAssertEquals  (s, n.ib, @"new singleton should be the same as sinleton IBOutlet;");
}
@end

@interface   SuperSingleton : AtoZSingleton   @end  @implementation   SuperSingleton @end
@interface     SubSingleton : SuperSingleton  @end  @implementation     SubSingleton @end
@interface AZSingletonTests : SenTestCase     @end  @implementation AZSingletonTests {id xx, x, y, z, superA, superB, subA, subB; }

- (void)setUp { [super setUp];

           x = AtoZSingleton.shared;       y = AtoZSingleton.new;              z = AtoZSingleton.alloc.init;

      superA = SuperSingleton.shared; superB = [SuperSingleton alloc].init; subA = [SubSingleton new];  subB = [SubSingleton instance];
}

- (void) testInstantiation	{

  xx = [objc_msgSend(AtoZSingleton.class, @selector(allocWithZone:), NSDefaultMallocZone()) init];

	STAssertTrue    (   x && y && z,                @"Objects shallnt beith nil");
	STAssertTrue    (   x == y && y == z && z == x, @"no matter how you slice it, they should be the same.");
  STAssertTrue    (  xx == x,                     @"Even crazy objects shall comply with the rules of one!");
}
- (void) testNoCopyAndUnrecognizedSelectors	{  id aCopy = nil;

  STAssertThrows  ( aCopy = [z copy], @"Attempts to copy the sigleton will Throw an exception.");
  STAssertNil     ( aCopy, @"copy shallnt exist, yo.");
}
- (void) testSameness         {

	AtoZSingleton *s1 = AtoZSingleton.shared,
                *s2 = AtoZSingleton.alloc.init;   STAssertEqualObjects	(s1, s2, @"Objects must be equal");
	AtoZSingleton *s3 = AtoZSingleton.new;      STAssertTrue(s1 == s2 && s1 == s3, @"Objects must be equal");
}
- (void) testIsInitialized  {

	AtoZSingleton *s = AtoZSingleton.shared;    STAssertTrue(s.inited, @"Singleton must be initialized");
}
- (void) testSubclassing    {

  STAssertTrue    ([superA isKindOfClass:SuperSingleton.class], @"");
  STAssertFalse   ([superA isKindOfClass:SubSingleton.class],   @"");
  STAssertTrue    ([subA   isKindOfClass:SuperSingleton.class], @"%@ should be a %@, which is it's superclass.",subA, NSStringFromClass(SuperSingleton.class));
  STAssertTrue    ([subA   isKindOfClass:  SubSingleton.class], @"");

//	FooSingleton *foo = FooSingleton.shared;    STAssertNotNil (foo, @"Object must not be nil");
//	BarSingleton *bar = BarSingleton.shared;  	STAssertNotNil (bar, @"Object must not be nil");
//	STAssertTrue   ([foo isKindOfClass:FooSingleton.class], @"");
//	STAssertTrue   ([bar isKindOfClass:BarSingleton.class], @"");
//	STAssertFalse  (foo == bar, @"Objects must not be equal!");
//	FooSingleton *foo2 = FooSingleton.new;
//	STAssertEqualObjects (foo, foo2, @"Objects must be equal");
}

@end


//- (void) awakeFromNib    { [super awakeFromNib]; NSLog(@"ride from my grave:%@", _ib); }