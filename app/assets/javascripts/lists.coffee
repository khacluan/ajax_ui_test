$ ->
  $(document).on "keypress", "#box_url input", (e) ->
    if e.keyCode == 13
      _value = $(this).val()
      _urlRegexp = new RegExp("^(?!mailto:)(?:(?:(?:http|https|ftp)://)|)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$", "i")

      if _urlRegexp.test(_value)
        _urls = getTextInsideLis("#results li")
        _value = _value.match(/\w+[^htps:\/w\.][^\/]*/i).pop()

        if $.inArray(_value, _urls) <= -1
          $("#results").prepend("<li class='new'>" + _value + "</li>")
        $(".error-message").html("")

        $.ajax
          url: "/lists"
          type: "POST"
          data:
            "urls": [_value]
          success: (response) ->
            if response == "successful"
              $("#results li.new").removeClass("new").addClass("loaded")
          error: (error) ->
      else
        $(".error-message").html("The URL is invalid!")
      $("#box_url input").val("")

  setInterval(syncData, 15000)

@syncData = ->
  _urls = getTextInsideLis("#results li.new")
  if _urls && _urls.length > 0
    $.ajax
      url: "/lists"
      type: "POST"
      data:
        "urls": _urls
      success: (response) ->
        if response == 'successful'
          $("#results li.new").removeClass('new').addClass('loaded')

@getTextInsideLis = (els)->
  $(els).map( ->
    return $(this).text()
  ).get()