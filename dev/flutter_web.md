

# Start
https://flutter.dev/docs/get-started/install/windows#get-the-flutter-sdk

https://flutter.dev/docs/get-started/web

    flutter channel stable
    flutter upgrade
    flutter devices
    flutter doctor

    flutter create myapp
    cd myapp
    flutter run # -d chrome

    flutter run --release # --web-renderer html or --web-renderer canvaskit

# Web renderers
https://flutter.dev/docs/development/tools/web-renderers

- HTML renderer  
Uses a combination of HTML elements, CSS, Canvas elements, and SVG elements. This renderer has a smaller download size.
- CanvasKit renderer  
This renderer is fully consistent with Flutter mobile and desktop, has faster performance with higher widget density, but adds about 2MB in download size.

# adaptive vs responsive
- Responsive  
Typically, a responsive app has had its layout tuned for the available screen size. Often this means (for example), re-laying out the UI if the user resizes the window, or changes the device’s orientation. This is especially necessary when the same app can run on a variety of devices, from a watch, phone, tablet, to a laptop or desktop computer.
- Adaptive  
Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more.
