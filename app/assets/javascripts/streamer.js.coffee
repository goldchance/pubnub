worker = ->
  $.ajax
    url: "get_messages"
    success: (data) ->
      append message for message in data

    complete: ->
      setTimeout worker, 500

append = (message) ->
  timetoken = parseInt($("#timetoken").html())
  if timetoken < message["timetoken"]
    msg = jQuery("<div/>",
      text: message["message"]
      class: 'list-group-item'
    )

    author = jQuery("<span/>",
      text: message["author"] + "@" + message["created_at"]
      class: 'badge'
    )

    author.appendTo msg
    msg.appendTo "#messages"

    $("#messages").stop().animate
      scrollTop: $("#messages")[0].scrollHeight
    , 800

    $("#timetoken").html(message["timetoken"])
    $("#message-field").val('')

$ ->
    ###$( '#carousel' ).elastislide()###
    MangeChattingRoom =  -> 
      $('.chattingroombox').show()
      if $('#chattingroomname').val() isnt ''
        $('#chattingroomname').val("")
      $('#chatroomlist').empty();      
      #for num in [1..1]
        # alert(num)                   
    $('#send-button').click ->
    $.ajax
      url: "publish"
      data: {
        author: $("#author-field").val()
        message: $("#message-field").val()
        pubchannel: localStorage['pubchannel']        
      }
      
    $('#btnStartChat').click ->      
      if $('#username').val() isnt ''
        username =  $('#username').val()
        localStorage['username'] = username        
        $.ajax
          url: "connect"
          data: {
              username: $('#username').val()
          }
        $('.usernamebox').hide()
        MangeChattingRoom()       
      else
        alert('Please enter user name!')
    $('#btnJoinChat').click ->      
      if $('#chattingroomname').val() isnt ''        
        pubchannel = $('#chattingroomname').val()
        localStorage['pubchannel'] = pubchannel
        $.ajax
          url: "subscribe"
          data: {
            pubchannel: $('#chattingroomname').val()
          }
        $('.chattingroombox').hide() 
        $('.chatwindow').show()
      else
        alert('Please enter chatting rooom name!')              
        
$ -> worker()
