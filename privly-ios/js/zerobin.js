/**
 * ZeroBin Privly Fork
 *
 * @link http://sebsauvage.net/wiki/doku.php?id=php:zerobin
 * @author sebsauvage
 * @contributor smcgregor
 *
 * This is a port of the ZeroBin project for a Privly injectable appliction.
 * See: 
 * https://github.com/privly/privly-organization/wiki/Injectable-Applications
 *
 * The application uses no template rendering, but it has several different
 * "modes" depending on the state of the URL on the application.
 * The "modes" are:
 * 1. Create new post. The application presents a form for typing content. The
 *    application will poll the server to see if the user is currently logged in
 *    and tells the user to log in if they are not currently.
 * 2. View content. The content is displayed along with links for creating
 *    new content.
 * 3. View content from within an iframe. Content is viewed in an iframe
 *    when the application has been injected into a web page. In this case, the
 *    post creation forms and information is not displayed. The end user does not
 *    need to know that the content they are viewing has been fetched from a 
 *    server and decrypted.
 *
 */

// Immediately start random number generator collector.
sjcl.random.startCollectors();

/**
 *  Converts a duration (in seconds) into human readable format.
 *
 *  @param int seconds
 *  @return string
 */
function secondsToHuman(seconds)
{
    if (seconds<60) { var v=Math.floor(seconds); return v+' second'+((v>1)?'s':''); }
    if (seconds<60*60) { var v=Math.floor(seconds/60); return v+' minute'+((v>1)?'s':''); }
    if (seconds<60*60*24) { var v=Math.floor(seconds/(60*60)); return v+' hour'+((v>1)?'s':''); }
    // If less than 2 months, display in days:
    if (seconds<60*60*24*60) { var v=Math.floor(seconds/(60*60*24)); return v+' day'+((v>1)?'s':''); }
    var v=Math.floor(seconds/(60*60*24*30)); return v+' month'+((v>1)?'s':'');
}

/**
 * Converts an associative array to an encoded string
 * for appending to the anchor.
 *
 * @param object associative_array Object to be serialized
 * @return string
 */
function hashToParameterString(associativeArray)
{
  var parameterString = ""
  for (key in associativeArray)
  {
      if( parameterString === "" )
      {
        parameterString = encodeURIComponent(key);
        parameterString += "=" + encodeURIComponent(associativeArray[key]);
      } else {
        parameterString += "&" + encodeURIComponent(key);
        parameterString += "=" + encodeURIComponent(associativeArray[key]);
      }
  }
  //padding for URL shorteners
  parameterString += "&p=p";
  
  return parameterString;
}

/**
 * Converts a string to an associative array.
 *
 * @param string parameter_string String containing parameters
 * @return object
 */
function parameterStringToHash(parameterString)
{
  var parameterHash = {};
  var parameterArray = parameterString.split("&");
  for (var i = 0; i < parameterArray.length; i++) {
    //var currentParamterString = decodeURIComponent(parameterArray[i]);
    var pair = parameterArray[i].split("=");
    var key = decodeURIComponent(pair[0]);
    var value = decodeURIComponent(pair[1]);
    parameterHash[key] = value;
  }
  
  return parameterHash;
}

/**
 * Get an associative arroy of the parameters found in the anchor
 *
 * @return object
 **/
function getParameterHash()
{
  var hashIndex = window.location.href.indexOf("#");
  if (hashIndex >= 0) {
    return parameterStringToHash(window.location.href.substring(hashIndex + 1));
  } else {
    return {};
  } 
}

/**
 * Compress a message (deflate compression). Returns base64 encoded data.
 *
 * @param string message
 * @return base64 string data
 */
function compress(message) {
    return Base64.toBase64( RawDeflate.deflate( Base64.utob(message) ) );
}

/**
 * Decompress a message compressed with compress().
 */
function decompress(data) {
    return Base64.btou( RawDeflate.inflate( Base64.fromBase64(data) ) );
}

/**
 * Compress, then encrypt message with key.
 *
 * @param string key
 * @param string message
 * @return encrypted string data
 */
function zeroCipher(key, message) {
    return sjcl.encrypt(key,compress(message));
}
/**
 *  Decrypt message with key, then decompress.
 *
 *  @param key
 *  @param encrypted string data
 *  @return string readable message
 */
function zeroDecipher(key, data) {
    return decompress(sjcl.decrypt(key,JSON.stringify(data)));
}

/**
 * @return the current script location (without search or hash part of the URL).
 *   eg. http://server.com/zero/?aaaa#bbbb --> http://server.com/zero/
 */
function scriptLocation() {
    var scriptLocation = window.location.href.substring(0,window.location.href.length
               - window.location.search.length - window.location.hash.length);
    var hashIndex = scriptLocation.indexOf("#");
    if (hashIndex !== -1) {
      scriptLocation = scriptLocation.substring(0, hashIndex)
    }
    return scriptLocation
}

/**
 * @return the paste unique identifier from the URL
 *   eg. 'c05354954c49a487'
 */
function pasteID() {
    return window.location.search.substring(1);
}

/**
 * Set text of a DOM element (required for IE)
 * This is equivalent to element.text(text)
 * @param object element : a DOM element.
 * @param string text : the text to enter.
 */
function setElementText(element, text) {
    // For IE<10.
    if ($('div#oldienotice').is(":visible")) {
        // IE<10 do not support white-space:pre-wrap; so we have to do this BIG UGLY STINKING THING.
        element.text(text.replace(/\n/ig,'{BIG_UGLY_STINKING_THING__OH_GOD_I_HATE_IE}'));
        element.html(element.text().replace(/{BIG_UGLY_STINKING_THING__OH_GOD_I_HATE_IE}/ig,"\r\n<br>"));
    }
    // for other (sane) browsers:
    else {
        element.text(text);
    }
}

/**
 * Show decrypted text in the display area, including discussion (if open)
 *
 * @param string key : decryption key
 * @param array comments : Array of messages to display (items = array with keys ('data','meta')
 */
function displayMessages(key, data) {
  
    try { // Try to decrypt the paste.
        var cleartext = zeroDecipher(key, data);
    } catch(err) {
        $('div#cleartext').hide();
        $('button#clonebutton').hide();
        showError('Could not decrypt data (Wrong key ?)');
        return;
    }
    setElementText($('div#cleartext'), cleartext);
    urls2links($('div#cleartext')); // Convert URLs to clickable links.
}

/**
 *  Send a new paste to server
 */
function send_data() {
  
  // Do not send if no data.
  if ($('textarea#message').val().length == 0) {
      return;
  }
  showStatus('Sending paste...', spin=true);
  var randomkey = sjcl.codec.base64.fromBits(sjcl.random.randomWords(8, 0), 0);
  var cipherdata = zeroCipher(randomkey, $('textarea#message').val());
  var cipher_json = JSON.parse(cipherdata);
  
  sharesFormSubmit($('#share_identity'),
                   $('#share_share_csv'),
                   $('#identity_provider_name'));
  var share = {
                can_show: $("#share_can_show").is(':checked'),
                can_update: $("#share_can_update").is(':checked'),
                can_destroy: $("#share_can_destroy").is(':checked'),
                can_share: $("#share_can_share").is(':checked'),
                identity: $("#share_identity").val(),
                share_csv: $("#share_share_csv").val(),
                identity_provider_name: $("#identity_provider_name").val()
              };
  var data_to_send = {
    post:{
      structured_content: cipher_json, 
      share: share, 
      public: $("#post_public").is(':checked')}};
  
  //Function called if the server returns successfully
  var successCallback = function (data, textStatus, jqXHR) {
    
    //We expect the remote server to return a header containing
    //the URL holding the structured content.
    if (jqXHR.getResponseHeader("X-Privly-Url") === undefined) {
      showError('Remote server did not return a URL.');
      return;
    }
    stateExistingPaste();
    
    //Form the URL for people to share it.
    var params = {"privlyLinkKey": randomkey,
      "privlyInjectableApplication": "ZeroBin",
      "privlyCiphertextURL": jqXHR.getResponseHeader("X-Privly-Url"),
      "privlyInject1": true};
    var url = scriptLocation() + '#' + hashToParameterString(params);
    showStatus('');

    $("#manage_link").attr("href", jqXHR.getResponseHeader("X-Privly-Url"));
    $('#manage_link_div').slideDown("slow");

    firePrivlyURLEvent(url);

    $('div#pastelink').html('Copy this address to share <br /> <a href="' + url + '" target="_blank">' + url + '</a>').show();
    setElementText($('div#cleartext'), $('textarea#message').val());
    urls2links($('div#cleartext'));
    showStatus('');
    $('div#cleartext').delay(800).slideUp("slow");
  };
  
  //Function called if there is a problem posting the data to the server
  var errorCallback = function (data, textStatus, jqXHR) { 
    showError('Data could not be sent (server error or not responding): ' + data.responseText);
  };
 
 privlyPostContent(data_to_send, successCallback, errorCallback);
}

/**
 * Put the screen in "New paste" mode.
 */
function stateNewPaste() {
    firePrivlyMessageSecretEvent();
    $('#loginprompt').hide();
    $('#toolbar').show();
    $('#share_form_elements').show();
    $('#privlyStylesheet').attr("disabled",true);
    $('button#sendbutton').show();
    $('button#clonebutton').hide();
    $('div#pastelink').hide();
    $('textarea#message').text($('div#cleartext').text());
    //$('textarea#message').text('');
    $('textarea#message').show();
    $('div#cleartext').hide();
    $('div#message').focus();
}

/**
 * Put the screen in "Login" mode.
 */
function stateLogin() {
  $('#loginprompt').show();
  $('#toolbar').show();
  $('#share_form_elements').hide();
  $('#privlyStylesheet').attr("disabled",true);
  $('button#sendbutton').hide();
  $('button#clonebutton').hide();
  $('div#pastelink').hide();
  $('textarea#message').hide();
  $('div#cleartext').hide();
}

/**
 * Put the screen in "Existing paste" mode.
 */
function stateExistingPaste() {
    $('button#sendbutton').hide();
    $('#share_form_elements').hide();
    
    // No "clone" for IE<10.
    if ($('div#oldienotice').is(":visible")) {
        $('button#clonebutton').hide();
    }
    else {
        $('button#clonebutton').show();
    }
    
    $('div#pastelink').hide();
    $('textarea#message').hide();
    $('div#cleartext').show();
}

/**
 * Display an error message
 * (We use the same function for paste and reply to comments)
 */
function showError(message) {
    $('div#status').addClass('errorMessage').text(message);
    $('div#replystatus').addClass('errorMessage').text(message);
}

/**
 * Display status
 * (We use the same function for paste and reply to comments)
 *
 * @param string message : text to display
 * @param boolean spin (optional) : tell if the "spinning" animation should be displayed.
 */
function showStatus(message, spin) {
    $('div#replystatus').removeClass('errorMessage');
    $('div#replystatus').text(message);
    if (!message) {
        $('div#status').html('&nbsp');
        return;
    }
    if (message == '') {
        $('div#status').html('&nbsp');
        return;
    }
    $('div#status').removeClass('errorMessage');
    $('div#status').text(message);
    if (spin) {
        var img = '<img src="/zero_bin/img/busy.gif" style="width:16px;height:9px;margin:0px 4px 0px 0px;" />';
        $('div#status').prepend(img);
        $('div#replystatus').prepend(img);
    }
}

/**
 * Convert URLs to clickable links.
 * URLs to handle:
 * <code>
 *     magnet:?xt.1=urn:sha1:YNCKHTQCWBTRNJIV4WNAE52SJUQCZO5C&xt.2=urn:sha1:TXGCZQTH26NL6OUQAJJPFALHG2LTGBC7
 *     http://localhost:8800/zero/?6f09182b8ea51997#WtLEUO5Epj9UHAV9JFs+6pUQZp13TuspAUjnF+iM+dM=
 *     http://user:password@localhost:8800/zero/?6f09182b8ea51997#WtLEUO5Epj9UHAV9JFs+6pUQZp13TuspAUjnF+iM+dM=
 * </code>
 *
 * @param object element : a jQuery DOM element.
 * @FIXME: add ppa & apt links.
 */
function urls2links(element) {
    var re = /((http|https|ftp):\/\/[\w?=&.\/-;#@~%+-]+(?![\w\s?&.\/;#~%"=-]*>))/ig;
    element.html(element.html().replace(re,'<a href="$1" rel="nofollow">$1</a>'));
    var re = /((magnet):[\w?=&.\/-;#@~%+-]+)/ig;
    element.html(element.html().replace(re,'<a href="$1">$1</a>'));
}

/**
 * Return the deciphering key stored in anchor part of the URL
 */
function pageKey() {
    
    var parameters = getParameterHash();
    
    var key = parameters["privlyLinkKey"];  // Get key

    // Some stupid web 2.0 services and redirectors add data AFTER the anchor
    // (such as &utm_source=...).
    // We will strip any additional data.

    // First, strip everything after the equal sign (=) which signals end of base64 string.
    i = key.indexOf('='); if (i>-1) { key = key.substring(0,i+1); }

    // If the equal sign was not present, some parameters may remain:
    i = key.indexOf('&'); if (i>-1) { key = key.substring(0,i); }

    // Then add trailing equal sign if it's missing
    if (key.charAt(key.length-1)!=='=') key+='=';

    return key;
}

/**
 * Return the url where the data is stored
 */
function cipherTextUrl() {
    return getParameterHash()["privlyCiphertextURL"];
}

/**
 * Tell the parent document (if it exists), the name and height
 * of this document. First it posts a message to the parent iframe,
 * then dispatches an event.
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
 * Request CSRF token and check permissions on current server
 */
function initializePosting() {
    //Asks for CSRF token and checks user's current permissions
    initPrivlyService(
      stateNewPaste, 
      function(){
        alert("Privly is in Closed Alpha. Your user account does not have permission to create new content");
        },
      stateLogin,
      function(jqXHR, textStatus, errorThrown){
        showError('You have been logged out of the content server and need to log back in.');
        stateLogin();
      }
    );
}

/**
 * On Page load, the forms and layouts are initialized.
 * If the URL's hash contains content, then the application
 * will attempt to fetch the remote ciphertext for decryption
 */
$(function() {
  
  //Dissable the Privly stylesheet by default.
  //It should only be active if the content is
  //being viewed in an iframe.
  $('#privlyStylesheet').attr("disabled",true);
  
    // This must be a new post if the hash is empty.
    // Otherwise the app will try to fetch, decryptand,
    // and render the content.
    if (window.location.hash.length == 0) {
      initializePosting();
    }
    else {
      
      // If if it in an iframe, show only the decrypted content.
      // This is managed by activating the Privly-specific
      // stylesheet and deactivating the ZeroBin Stylesheet
      if (self !== top) {
        $('#zerobinStylesheet').attr("disabled",true);
        $('#privlyStylesheet').attr("disabled",false);
        //Open the content on the content server if it is clicked
        $("body").on("click",function(evt){
          if(evt.target.nodeName !== "A") {
            window.open(window.location.href, '_blank');
          }
        });
        
        //Display tooltip indicating the content has been injected
        tooltip();
      }
      $("#toolbar").show();
      
      // This callback receives the data from the URL found on the hash
      var retrievedCiphertextCallback = function(data, textStatus, jqXHR) {
        stateExistingPaste();
        $("#manage_link").attr("href", cipherTextUrl());
        $('#manage_link_div').slideDown("slow");
        displayMessages(pageKey(), data.structured_content);
        postResizeMessage();
      };
      
      //This callback is fired if the person does not have access to the
      //content or there is some other error. In this state, the user will
      //see a new posting form.
      var failureFunction = function(data, textStatus, jqXHR) {
        initializePosting();
        showError('Could not retrieve your content. It might not exist, you might not have access, or there was a server error.');
      };
      
      //Get the content and fire the callbacks.
      privlyGetContent(cipherTextUrl(), retrievedCiphertextCallback, 
                      failureFunction);
    }
});
