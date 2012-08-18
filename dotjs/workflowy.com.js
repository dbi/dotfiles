$(".editor > textarea").bind("keydown","alt+up",function() { $(this).getProject().getPreviousSibling().children(".name").moveCursorToBeginning(); return false;});
$(".editor > textarea").bind("keydown","alt+down",function() { $(this).getProject().getNextSibling().children(".name").moveCursorToBeginning(); return false;});
$("#dropdownMessages").hide();
$('#share_buttons').hide();
