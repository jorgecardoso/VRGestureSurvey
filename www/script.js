$(document).ready(function() { 
  
  // show/hide image slides
  // clicking on thumb shows unslider
  // clicking outside slides hides them
  $(document).on("click", ".thumb", onClick);
    
  function onClick(obj) {
    obj.stopPropagation();
    // we recreate unslider for each set of slides
    createSlides( $(this).find('img').attr("data") );
    $(document).on("click", offClick);
  }
   
  function offClick(e) {
    if ($(e.target) == $(".unslider:first") || $(e.target).parents(".unslider:first").size()) { 
      return;
    } else { 
      $("#unslider").empty().hide();
      
      $(document).off("click");
      $(document).on("click", ".thumb", onClick);   
    }
      
  }
   
  $("#unslider").hide();

});


function createSlides(data) {
  var urls = data.split('\n');
  $("#unslider").empty().show();
  $("#unslider").append("<div></div>")
  $("#unslider div").append("<ul></ul>");
  urls.forEach(function(s) {
    $("#unslider ul").append("<li><img src=\'" + s + "\'> </li>");
  });
  
  $('#unslider div').unslider({
        fluid: true,
        nav: urls.length>1?true:false,
        arrows: urls.length>1?true:false
    });
  
}

function createThumbs(data, type, row, meta) {
  //console.log(data );
  var urls = data.split('\n');
  var thumbs = '<span class=thumb>';
  if (urls.length > 0 && urls[0].length > 1) {
    thumbs+= '<img src=\'no-image-icon-13.png\' data=\'' + data +'\'>';
  }
 
  thumbs += '</span>';
  return thumbs;
}