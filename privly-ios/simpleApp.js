//
//  simpleApp.js
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

// Communicate with iOS app by creating a new frame and passing the URL in src
var iframe = document.createElement("IFRAME");
iframe.setAttribute("src", "js-frame:myObjectiveCFunction");
iframe.setAttribute("height", "1px");
iframe.setAttribute("width", "1px");
document.documentElement.appendChild(iframe);
iframe.parentNode.removeChild(iframe);
iframe = null;
