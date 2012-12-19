//
//  Test.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import "TestCase.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation TestCase

- (void)runTests
{
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *selectorName = NSStringFromSelector(selector);
        if ([selectorName hasPrefix:@"test"])
        {
            //avoid arc warning by using c runtime
            objc_msgSend(self, selector);
        }
		
		NSString *testName = [selectorName substringFromIndex:4];
        NSLog(@"Test '%@' completed successfuly", testName);
    }
}

@end
