Purpose
--------------

NullSafe is a simple category on NSNull that returns nil for unrecognised messages instead of throwing an exception. This eliminates a common cause of crashes, where (for example) JSON data contains a null value instead of an array or string, and the network code in the app isn't expecting it.

**Note:** Unlike nil, NullSafe will currently only respond to messages supported by NSValue, NSNumber, NSString, NSDictionary, NSArray, NSData and NSData (basically anything you might find in a Plist or JSON file). Any messages not supported by those objects will throw an exception as normal.


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 6.0 / Mac OS 10.8 (Xcode 4.5.2, Apple LLVM compiler 4.1)
* Earliest supported deployment target - iOS 5.0 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

NullSafe works in both ARC and non ARC targets without modification.


Installation & Usage
--------------------

To use NullSafe, just drag the NullSafe.h and .m files into your project. NullSafe will be automatically loaded at runtime, you don't need to include the header file in your code.