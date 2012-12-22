//
//  NullSafe.m
//
//  Version 1.2
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

#import "NullSafe.h"
#import <objc/runtime.h>


@implementation NSNull (NullSafe)

#if NULLSAFE_ENABLED

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    @synchronized([self class])
    {
        //look up method signature
        NSMethodSignature *signature = [super methodSignatureForSelector:selector];
        if (!signature)
        {
            //not supported by NSNull, search other classes
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            if (signatureCache == nil)
            {
                classList = [[NSMutableSet alloc] init];
                signatureCache = [[NSMutableDictionary alloc] init];
                
                //get class list
                int numClasses = objc_getClassList(NULL, 0);
                Class *classes = (Class *)malloc(sizeof(Class) * numClasses);
                numClasses = objc_getClassList(classes, numClasses);
                
                //add to list for checking
                NSMutableSet *excluded = [NSMutableSet set];
                for (int i = 0; i < numClasses; i++)
                {
                    //determine if class has a superclass
                    BOOL isNSObject = NO;
                    Class class = classes[i];
                    Class superClass = class_getSuperclass(class);
                    while (superClass)
                    {
                        if (superClass == [NSObject class])
                        {
                            isNSObject = YES;
                            break;
                        }
                        Class next = class_getSuperclass(superClass);
                        if (next) [excluded addObject:superClass];
                        superClass = next;
                    }
                    
                    //only include NSObject subclasses
                    if (isNSObject)
                    {
                        [classList addObject:class];
                    }
                }
                
                //remove all classes that have subclasses
                for (Class class in excluded)
                {
                    [classList removeObject:class];
                }
                
                //free class list
                free(classes);
            }
            
            //check implementation cache first
            NSString *selectorString = NSStringFromSelector(selector);
            signature = [signatureCache objectForKey:selectorString];
            if (!signature)
            {
                //find implementation
                for (Class class in classList)
                {
                    if ([class instancesRespondToSelector:selector])
                    {
                        signature = [class instanceMethodSignatureForSelector:selector];
                        break;
                    }
                }
                
                //cache for next time
                [signatureCache setObject:signature ?: [NSNull null] forKey:selectorString];
            }
            else if ([signature isKindOfClass:[NSNull class]])
            {
                signature = nil;
            }
        }
        return signature;
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:nil];
}

#endif

@end
