//
//  JSONTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import "NullTests.h"
#import "NullSafe.h"


@implementation NSData (NullTests)

- (double)NullTestMethod
{
    return 47.6;
}

@end


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
    float x = floorf(123.456f);
    float result = [nullValue floatValue];
    NSAssert(result == 0.0f, @"FloatValue test failed (%g)", x);
}

- (void)testFloatValue2
{
    id nullValue = [NSNull null];
    float x = floorf(123.456f);
    float result = [nullValue floatValue];
    NSAssert(result == 0.0f, @"FloatValue2 test failed (%g)", x);
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

- (void)testRange
{
    id nullValue = [NSNull null];
    NSRange compare = NSMakeRange(0, 0);
    NSMakeRange(1, 10);
    NSRange result = [nullValue range];
    NSAssert(NSEqualRanges(result, compare), @"Range test failed");
}

- (void)testCategory
{
    id nullValue = [NSNull null];
    double x = floorf(123.456);
    double result = [nullValue NullTestMethod];
    NSAssert(result == 0.0, @"Category test failed (%g)", x);
}

@end