//
//  NullTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import <XCTest/XCTest.h>


@implementation NSData (NullTests)

- (double)NullTestMethod
{
    return 47.6;
}

@end


@interface NullTests : XCTestCase

@end


@implementation NullTests

- (void)testStringValue
{
    id nullValue = [NSNull null];
    NSString *result = [nullValue stringValue];
    XCTAssertNil(result);
}

- (void)testFloatValue
{
    id nullValue = [NSNull null];
    __unused float x = floorf(123.456f); // makes sure compiler doesn't trick us
    float result = [nullValue floatValue];
    XCTAssertEqualWithAccuracy(result, 0.0f, 0.0f);
}

- (void)testPointerValue
{
    id nullValue = [NSNull null];
    const void *result = [nullValue bytes];
    XCTAssertNil((__bridge id)result);
}

- (void)testClass
{
    id nullValue = [NSNull null];
    NSString *result = NSStringFromClass([nullValue class]);
    XCTAssertEqualObjects(result, @"NSNull");
}

- (void)testDescription
{
    id nullValue = [NSNull null];
    NSString *result = [nullValue description];
    XCTAssertEqualObjects(result, @"<null>");
}

- (void)testRange
{
    id nullValue = [NSNull null];
    NSRange compare = NSMakeRange(0, 0);
    NSMakeRange(1, 10);
    NSRange result = [nullValue range];
    XCTAssertTrue(NSEqualRanges(result, compare), @"Range test failed");
}

- (void)testCategory
{
    id nullValue = [NSNull null];
    __unused double x = floor(123.456);
    double result = [nullValue NullTestMethod];
    XCTAssertEqualWithAccuracy(result, 0.0, 0.0);
}

@end
