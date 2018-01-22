# ODRExample
iOS On Demand Resources Example

## Update Problem

I'm developing a project for our customer that uses on demand resources. When we update the app, creating new on demand resource tags, the app will not load the new tags. This only happens when distributing the app using enterprise over-the-air distribution, and updating an installed copy of the app. When running from Xcode on a device or in the simulator everything runs as expected.

To see this in action check out commit 3c1690b, archive that version, build and publish it for enterprise distribution, and install it on a device. Run the app and see that the app does not have a second image. Then move forward to the latest commit, build, publish, and install that new version over the older version. Running the app will result in a error message saying the app can't load the second image. The app must have been told by the callback for `conditionallyBeginAccessingResources` or `beginAccessingResources` that the resources are available, yet calling `UIImage(named:)` returns a nil.

### P.S.

This is a quickly made app including the bare minimum to demonstrate this issue. I've excluded many best practices I would normally include in production projects such as testing.