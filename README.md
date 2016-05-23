[![Build Status](https://travis-ci.org/nicklockwood/NullSafe.svg)](https://travis-ci.org/nicklockwood/NullSafe)


Purpose
--------------

NullSafe is a simple category on NSNull that returns nil for unrecognised messages instead of throwing an exception. This eliminates a common cause of crashes, where (for example) JSON data contains a null value instead of an array or string, and the network code in the app isn't expecting it.


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 9.3 / Mac OS 10.11 (Xcode 7.3, Apple LLVM compiler 7.1)
* Earliest supported deployment target - iOS 7.0 / Mac OS 10.9
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

NullSafe works in both ARC and non ARC targets without modification.


Installation & Usage
--------------------

To use NullSafe, just drag the NullSafe.m file into your project. NullSafe will be automatically loaded at runtime, you don't need to include any header files in your code.


Selectively Disabling NullSafe
------------------------------

NullSafe is enabled automatically as soon as the class files are added to a project target, however if you wish to disable NullSafe for a particular scheme (e.g. when running in debug mode) then you can disable it by adding the following pre-compiler macro to your build settings:

    NULLSAFE_ENABLED=0

Or if you prefer, you could add something like this to your prefix.pch file:
    
    #ifdef DEBUG
    #define NULLSAFE_ENABLED 0
    #endif


Release Notes
--------------
 
Version 1.2.2
 
- Fixed nullability warning

Version 1.2.1

- Fixed crash in iOS 8
- Removed NullSafe.h file (redundant)
- Now complies with -Weverything warning level

Version 1.2

- Will now handle any known method, not just a subset
- Added NULLSAFE_ENABLED macro to easily enable/disable per scheme
- Added implementation cache for better performance

Version 1.1

- Made it work by design rather than coincidence ;-)

Version 1.0

- Initial release