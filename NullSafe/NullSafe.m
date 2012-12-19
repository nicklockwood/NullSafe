//
//  NullSafe.m
//
//  Version 1.0
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

id NullSafeMethodIMP(id, SEL, ...);

id NullSafeMethodIMP(id self, SEL cmd, ...)
{
    return nil;
}

@implementation NUSNull

+ (void)load {
	[super load];
	Method resolveInstanceMethod = class_getClassMethod(NSNull.class, @selector(resolveInstanceMethod:));
	Method newResolveInstanceMethod = class_getClassMethod(self.class, @selector(resolveInstanceMethod:));
	
	method_exchangeImplementations(resolveInstanceMethod, newResolveInstanceMethod);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod(self, sel, NullSafeMethodIMP, "v@:@");
    return YES;
}

@end
