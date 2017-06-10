// border-radius
// Jonah Fox
// MIT Licensed
// Use like : $(".myClass").borderRadius() will attempt to apply curved corners as per the elements -moz-border-radius attribute
// Good:
//   - supports textured forgrounds and backgrounds
//   - maintains layouts
//   - very easy to use
//   - IE6 and IE7
// Bad: 
//   - not fluid. Reapply if the dimensions change 
//   - only supports rounding all corners
//   - no hover
//   - no Opera

;(function($){

  if($.browser.msie && document.namespaces["v"] == null) {
    document.namespaces.add("v", "urn:schemas-microsoft-com:vml");
    var ss = document.createStyleSheet().owningElement;
    ss.styleSheet.cssText = "v\\:*{behavior:url(#default#VML);}"
  }

  function RR(o) {
    var html = '<div class="ie_border_radius" style="position: absolute; left: 0px; top: 0px; z-index: -1; width:' + (o.width) + "px;height:" + (o.height) + 'px;">'
    html += '<v:roundrect arcsize="' + o.arcSize + '" strokecolor="' + o.strokeColor + '" strokeweight="' + o.strokeWeight + '" style="behavior: url(#default#VML); position:absolute;  antialias: true; width:' + (o.width) + "px;height:" + (o.height) + 'px;' + "" + '" >';
    html += '<v:fill color="' + o.fillColor + '" src="' + o.fillSrc + '" type="tile" style="behavior: url(#default#VML);" />';
    html += '</v:roundrect>';
    html += "</div>"
      
	  return html;
  }

  $.fn.borderRadius = !$.browser.msie ? function() {} : function(options){    
	 
  	  var options = options || {}
   
      return this.each(function() {
        
        var opts = {}
        
	    	if(this._border_radius_opts) {
    			opts = this._border_radius_opts
    		  $(this).find(".ie_border_radius").remove();
    		}
        else
        {
    			opts.strokeColor = this.currentStyle.borderColor; 
    			opts.strokeWeight = this.currentStyle.borderWidth; 

    			opts.fillColor = this.currentStyle.backgroundColor; 
    			opts.fillSrc = this.currentStyle.backgroundImage.replace(/^url\("(.+)"\)$/, '$1'); 

    			this.style.border = 'none'; // perhaps add onto padding?
    			this.style.background = 'transparent';
    			this._border_radius_opts = opts
    		}

    		opts.width = $(this).outerWidth() 
    		opts.height = $(this).outerHeight() 
    		
    		var r = options.radius || parseInt( this.currentStyle['-ie-border-radius'] ||  this.currentStyle['-moz-border-radius'] || this.currentStyle['moz-border-radius'] );

    		opts.arcSize = Math.min( r / Math.min(opts.width, opts.height), 1);
   
        this.innerHTML +=  RR(opts);
        
        if(this.currentStyle.position != "absolute")
          this.style.position = "relative";
          
     	  
        this.style.zoom = 1; // give it a layout 
      });
    }
})(jQuery);

