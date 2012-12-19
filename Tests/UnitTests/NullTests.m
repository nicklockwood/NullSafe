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
    float result = [nullValue floatValue];
    NSAssert(result == 0.0f, @"FloatValue test failed");
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

@end