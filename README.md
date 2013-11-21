RMHelpfulLabel
==============

A customisable `UILabel` implementation that allows easily adding pop-up, context-sensitive help

A demo project showing most of the features is included.

![Demo image 1](Images/demoImage1.png) ![Demo image 2](Images/demoImage2.png) 

MIT Licensed, so do what you will.  I'd love to know if you're using it, and any other feature requests or general feedback are very welcome!

Installation
============

Drag `RMHelpfulLabelh` and `RMHelpfulLabel.m` to your project.

Use
===
Create your `UILabel`s as usual in Interface Builder.  Set their custom class to `RMHelpfulLabel`
and add a couple of User Defined Runtime Attributes in the inspector: helpText (mandatory) and helpTitle (optional).

![User Defined Runtime Attributes](Images/UserDefinedRuntimeAttributes.png)

In your Controller toggle the help visibility with a call to `[RMHelpfulLabel setHelpEnabled:]`

Various customisations exist - check the demo project.

That's it.