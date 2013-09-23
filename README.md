About
=====
Privly is a developing set of browser extensions for protecting content wherever it is posted on the internet. This extension allows users to view content on any website, without the host site being able to read the content. 

privly-ios
==========

This is the repository for the Privly iOS application. 

For more information on what Privly is, see https://priv.ly.

The development home of Privly is at http://www.privly.org/. For information on how to join the Privly community, read this: http://www.privly.org/content/welcome-privly-development

About this App
==============

The privly-ios app has two modes:

Content Posting and Sharing
---------------------------

+ Locally stored applications: The iOS app runs no remote-code.
  + *PlainPost Application*: The PlainPost application supports content injection of web pages from any source domain. Note: the injected web pages do not include external media and code.
  + *ZeroBin Application*: The ZeroBin application encrypts content with a key unique to the URL. Anyone with access to both the host page and the content server will be able to decrypt the content. Anyone without access to the server will be unable to decrypt the content.
+ Generated links can be posted on the Facebook and Twitter social networks.

Content Reading
---------------

+ Privly links can be pulled from the authenticated user's Facebook posts and Twitter tweets. They are then opened in a locally stored application.

Requirements
============

To test the app in a simulator, you will need:

+ Mac OS X 10.8.4+
+ Xcode 5

In addition, to test the app on a device, you will need:

+ An iOS developer license

Running privly-ios
==================

+ Clone this repository.
+ Clone [privly/privly-applications][1] in the /privly-ios folder
+ Run the app in your simulator

Testing/Submitting Bugs
=======================

If you have discovered a bug, only [open a public issue][2] on GitHub if it could not possibly be a security related bug. If the bug affects the security of the system, please report it privately at [privly.org][3]. We will then fix the bug and follow a process of responsible disclosure.

Developer Documentation
=======================

Build the documentation by running the command below in the root directory of your repository:
`doxygen privlydoc`

Resources
=========

[Foundation Home](http://www.privly.org)  
[Privly Project Repository List](https://github.com/privly)  
[Development Mailing List](http://groups.google.com/group/privly)  
[Testing Mailing List](http://groups.google.com/group/privly-test)  
[Announcement Mailing List](http://groups.google.com/group/privly-announce)  
[Mobile Mailing List](http://groups.google.com/group/privly-mobile)  
[Central Wiki](https://github.com/privly/privly-organization/wiki)  
[IRC](http://www.privly.org/content/irc)  
[Production Content Server](https://privlyalpha.org)  
[Development Content Server](https://dev.privly.org)  
[Download Extension](https://priv.ly/pages/download)

Contacts
========

**Email**:  
hery at ratsimihah dot com

**Mail**:  
Privly  
PO Box 79  
Corvallis, OR 97339  

**IRC**:  
Contact the nicks "hratsimihah" or "smcgregor" on irc.freenode.net #privly

**Bug**:  
If you open a bug on this repository, you'll get someone's attention

[1]: https://github.com/privly/privly-applications
[2]: https://github.com/privly/privly-ios/issues/new
[3]: http://www.privly.org/content/bug-report
