//
//  NullSafe.m
//
//  Version 2.0
//
//  Created by Nick Lockwood on 19/12/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/NullSafe
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>


#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif


#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"


@implementation NSNull (NullSafe)

#if NULLSAFE_ENABLED

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        for (Class someClass in @[
            [NSMutableArray class],
            [NSMutableDictionary class],
            [NSMutableString class],
            [NSNumber class],
            [NSDate class],
            [NSData class]
        ])
        {
            @try
            {
                if ([someClass instancesRespondToSelector:selector])
                {
                    signature = [someClass instanceMethodSignatureForSelector:selector];
                    break;
                }
            }
            @catch (__unused NSException *unused) {}
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}

#endif

@end
