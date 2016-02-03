Handpoint getting started sample version 1.1

- This sample project uses the methods descriped in the getting started guide found on the Handpoint documentations site (https://www.handpoint.com/docs/device/iOS/#section_gettingStarted).

- There are some additional functions in this project to better explain how the Handpoint iOS SDK works.

- If you have a Handpoint card reader then you can download our SDK from https://www.handpoint.com/docs/device/iOS/ and replace the libheftsimulator.a file (in the HeftLibrary folder of this project) with the libheft.a that comes with the SDK to use the Handpoint card reader.

- This sample project assumes that the simulator is being used which uses the development shared secret: 0102030405060708091011121314151617181920212223242526272829303132. 
- **Integrators using a Handpoint card reader should replace this (NSString* sharedSecret at the top of the file ViewController.m) with the shared secret provided to him with his development card reader.**

- The project was last built using Xcode 7.2
