// make sure jQuery is included

g = document.getElementsByTagName('frameset')[0];
g.rows = "0,0,*";

jQuery(function() {
  setTimeout(function() {
    jQuery(".wrapperfixed", parent.frames[2].document).hide();
    jQuery("#hud", parent.frames[2].document).hide();
  }, 1500);
});
