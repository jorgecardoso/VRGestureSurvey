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

var table;
function initComplete( ) {
  table = this;
  this.api().columns(2).every( function (ci) {
          console.log("Column index: " + ci);
                var column = this;
                var select = $('<select style="width:100px"><option value=""></option></select>')
                  //.appendTo( $(column.header()).empty() )
                    .appendTo( $("table thead tr:nth-child(2) td:nth-child("+(ci+1)+")").empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
 
                        column.search(val, true).draw();
                    } );
                var searchItems = [];
                column.data().unique().sort().each( function ( d, j ) {
                   var items = d.split("+");
                    //select.append( '<option value="'+d+'">'+d+'</option>' )
                    items.forEach(function(s) {
                      
                      var cleaned = s.replace(/\([\s\S]*\)/i, "").trim();
                      
                      if ( !searchItems.includes(cleaned) ) {
                        searchItems.push(cleaned);  
                      }
                    });
                    
                } );
                
                
                searchItems.sort().forEach(function(s) {
                  console.log(s);
                  select.append( '<option value="'+s+'">'+s+'</option>' )
                })
                
            } );
}