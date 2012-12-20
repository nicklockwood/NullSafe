//
//  JSONTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import "NullTests.h"
#import "NullSafe.h"

@implementation NullTests

- (void)testStringValue
{
    id nullValue = [NSNull null];
    NSString *result = [nullValue stringValue];
    NSAssert(result == nil, @"StringValue test failed");
}

- (void)testFloatValue
{
    id nullValue = [NSNull null];
    float x = floorf(123.456);
    float result = [nullValue floatValue];
    NSAssert(result == 0.0f, @"FloatValue test failed (%g)", x);
}

- (void)testPointerValue
{
    id nullValue = [NSNull null];
    const void *result = [nullValue bytes];
    NSAssert(result == NULL, @"PointerValue test failed");
}

- (void)testClass
{
    id nullValue = [NSNull null];
    NSString *result = NSStringFromClass([nullValue class]);
    NSAssert([result isEqualToString:@"NSNull"], @"Class test failed");
}

- (void)testDescription
{
    id nullValue = [NSNull null];
    NSString *result = [nullValue description];
    NSAssert([result isEqualToString:[[NSNull null] description]], @"Description test failed");
}

- (void)testUnsupported
{
    BOOL threwUp = NO;
    @try
    {
        id nullValue = [NSNull null];
        [nullValue data]; //unsupported method
    }
    @catch (NSException *exception)
    {
        threwUp = YES;
    }
    NSAssert(threwUp, @"Unsupported test failed");
}

@end