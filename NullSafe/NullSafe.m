//
//  NullSafe.m
//
//  Version 1.2.3
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


#pragma GCC diagnostic ignored "-Wgnu-conditional-omitted-operand"


@implementation NSNull (NullSafe)

#if NULLSAFE_ENABLED

static NSMutableSet<Class> *classList = nil;
static NSMutableDictionary<NSString *, id> *signatureCache = nil;
static void cacheSignatures()
{
    classList = [[NSMutableSet alloc] init];
    signatureCache = [[NSMutableDictionary alloc] init];

    //get class list
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);
    numClasses = objc_getClassList(classes, numClasses);

    //add to list for checking
    for (int i = 0; i < numClasses; i++)
    {
        //determine if class has a superclass
        Class someClass = classes[i];
        Class superclass = class_getSuperclass(someClass);
        while (superclass)
        {
            if (superclass == [NSObject class])
            {
                [classList addObject:someClass];
                [classList removeObject:[someClass superclass]];
                break;
            }
            superclass = class_getSuperclass(superclass);
        }
    }

    //free class list
    free(classes);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        //check implementation cache first
        NSString *selectorString = NSStringFromSelector(selector);
        signature = signatureCache[selectorString];
        if (!signature)
        {
            @synchronized([NSNull class])
            {
                //check again, in case it was resolved while we were waitimg
                signature = signatureCache[selectorString];
                if (!signature)
                {
                    //not supported by NSNull, search other classes
                    if (signatureCache == nil)
                    {
                        if ([NSThread isMainThread])
                        {
                            cacheSignatures();
                        }
                        else
                        {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                cacheSignatures();
                            });
                        }
                    }

                    //find implementation
                    for (Class someClass in classList)
                    {
                        if ([someClass instancesRespondToSelector:selector])
                        {
                            signature = [someClass instanceMethodSignatureForSelector:selector];
                            break;
                        }
                    }

                    //cache for next time
                    signatureCache[selectorString] = signature ?: [NSNull null];
                }
                else if ([signature isKindOfClass:[NSNull class]])
                {
                    signature = nil;
                }
            }
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
