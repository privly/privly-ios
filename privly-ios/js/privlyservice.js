/**
 * This script defines the Privly-specific functionality for the Privly's 
 * ZeroBin fork. It handles posting content to the server, getting content 
 * from the server, sending resize messages, and fireing URL events.
 *
 * Success callbacks use the response's structured_content JSON document.
 * If the request fails {error:"message"} is used.
 */

/** 
 * Get, decrypt, display, then resize for content.
 *
 * @param url string The URL of the content to fetch.
 *
 * @param successCallback function the function to call after the content 
 * successfully returns. The callback is expected to accept three parameters: 
 * data, textStatus, and jqXHR.
 *
 * @param failureCallback function the function to call after the content 
 * fails to return. The callback is expected to accept three parameters: 
 * data, textStatus, and jqXHR.
 *
 */
function privlyGetContent(url, successCallback, failureCallback) {
  $.getJSON(url)
    .success(
      successCallback
    )
    .error(
      failureCallback
    );
  return;
}

/**
 * Fire an event containing the Privly URL for extensions to capture.
 * This is used in posting dialogs where the application pops up for the
 * user to create a post.
 *
 * @param url string The URL to send to extensions.
 *
 */
function firePrivlyURLEvent(url) {
  var element = document.createElement("privlyEventSender");  
  element.setAttribute("privlyUrl", url);  
  document.documentElement.appendChild(element);  

  var evt = document.createEvent("Events");  
  evt.initEvent("PrivlyUrlEvent", true, false);  
  element.dispatchEvent(evt);
}

/**
 * Post content to the content server and generate the new resource's URL.
 *
 * @param data_to_send JSON The JSON document getting posted to the server.
 * @param successCallback The function to execute after the content server
 * returns successfully.The callback is expected to accept three parameters: 
 * data, textStatus, and jqXHR.
 * @param errorCallback The function to execute after the content server
 * returns in a failure state.The callback is expected to accept three 
 * parameters: data, textStatus, and jqXHR.
 */
function privlyPostContent(data_to_send, successCallback, errorCallback) {
  
  var url = window.location.protocol + "//" + window.location.host + "/posts";
  
  $.ajax({
    data: data_to_send,
    type: "POST",
    url: url,
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    dataType: "json",
    accepts: "json",
    success: successCallback,
    error: errorCallback
  });
}

/**
 * Show the form if the user has posting permission, otherwise tell the user to
 * sign in. Also adds the CSRF token to all requests.
 *
 * @param canPostCallback function the function to execute when initialization is 
 * successful.
 *
 * @param loginCallback function the function to execute if the user is not logged
 * in.
 *
 * @param cantPostLoginCallback function the function to execute if the user is logged
 * in but their user account does not have posting permission.
 *
 * @param errorCallback function the function to execute if the remote server is not
 * available.
 * 
 */
function initPrivlyService(canPostCallback, cantPostLoginCallback, loginCallback, errorCallback) {
  var csrfTokenAddress = window.location.protocol + "//" + window.location.host + "/posts/user_account_data";
  
  $.ajax({
    url: csrfTokenAddress,
    dataType: "json",
    success: function (json, textStatus, jqXHR) {
      $.ajaxSetup({
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', json.csrf);
      }});
      
      if(json.signedIn && json.canPost) {
        canPostCallback();
      } else if(json.signedIn) {
        cantPostLoginCallback();
      } else {
        loginCallback();
      }
    },
    error: function (jqXHR, textStatus, errorThrown) {
      errorCallback(jqXHR, textStatus, errorThrown);
    }
  });
}

/**
 * Tell the parent document (if it exists), the name and height
 * of this document. First it posts a message to the parent iframe,
 * then dispatches an event. Browsers have different permissions 
 * regarding message passing, so both a postmessage and event dispatch
 * are required.
 */
function postResizeMessage() {
  
  if (top !== self) {
    var newHeight = document.getElementById("privlyHeightWrapper").offsetHeight;
    parent.postMessage(window.name+","+newHeight,"*");

    var evt = document.createEvent("Events");  
    evt.initEvent("IframeResizeEvent", true, false);
    var element = document.createElement("privElement");
    element.setAttribute("height", newHeight);  
    element.setAttribute("frameName", window.name);  
    document.documentElement.appendChild(element);    
    element.dispatchEvent(evt);
  }
}

/**
 * Handles posted messages by checking whether they have the appropriate
 * secret. Take note that this function returns a callback, it is not the
 * callback itself.
 *
 * @param secret string the secret string that only the extension can know.
 *
 * @return a function for handling message events.
 */
function messageHandler(secret) {
  return function(message) {
    if( message.data.indexOf(secret) === 0 ) {
      var remaining = message.data.substr(secret.length);
      if ( remaining.indexOf("InitialContent") === 0 ) {
        $("#message").val(
          remaining.substring("InitialContent".length));
      } else if ( remaining.indexOf("Submit") === 0 ) {
        send_data();
      }
    }
  }
}

/**
 * Send a random sequence of characters to privly-type extensions.
 * Messages containing the random sequence will be assumed to come
 * from the extensions.
 */
function firePrivlyMessageSecretEvent() {
    
  var secret = Math.random().toString(36).substring(2) + 
               Math.random().toString(36).substring(2) +  
               Math.random().toString(36).substring(2);
  
  var messageSecretElement = document.getElementById("message");
  if ( messageSecretElement !== undefined && 
    messageSecretElement !== null ) {
      messageSecretElement.setAttribute("privlyMessageSecret", secret);  
      var evt = document.createEvent("Event");  
      evt.initEvent("PrivlyMessageSecretEvent", true, false);  
      window.addEventListener("message", 
        messageHandler(secret),
        false);
      messageSecretElement.dispatchEvent(evt);
    }
}

