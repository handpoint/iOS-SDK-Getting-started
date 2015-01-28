Handpoint getting started sample version 1.0

- This sample project uses the methods descriped in the getting started guide found on the Handpoint documentations site (https://www.handpoint.com/docs/device/iOS/#section_gettingStarted).

- There are some additional functions in this project to better explain how the Handpoint iOS SDK works.

- This sample project assumes that an integrator has a development card reader, that uses the development shared secret: 0102030405060708091011121314151617181920212223242526272829303132, connected to an iOS device. **Integrator should replace this (NSString* sharedSecret at the top of the file ViewController.m) with the shared secret provided to him with his development card reader.**

- The project was created using Xcode version 5.1.1 and has been tested on the following devices:
iPhone 5s running iOS 7.1.2
iPhone 5 running iOS 7.1.2
iPhone 4s running iOS 7.1
iPhone 4 running iOS 6.1.3

- If you don't have a Handpoint Card Reader then you can download our SDK from https://www.handpoint.com/docs/device/iOS/ and replace the libheft.a file (in the HeftLibrary folder of this project) with the libheftsimulator.a that comes with the SDK.
