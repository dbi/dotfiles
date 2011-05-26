-- source: http://techiferous.com/2009/12/streamlining-your-workflow-with-applescript/
on replace_chars(this_text, search_string, replacement_string)
  set AppleScript's text item delimiters to the search_string
  set the item_list to every text item of this_text
  set AppleScript's text item delimiters to the replacement_string
  set this_text to the item_list as string
  set AppleScript's text item delimiters to ""
  return this_text
end replace_chars

-- source (modified): http://macscripter.net/viewtopic.php?id=14995
on jot_dialog for q
	set default_input to {"","","","",""}
	set {d, text item delimiters} to {text item delimiters, return}
	set {q, default_input, text item delimiters} to {q as string, default_input as string, d}
    
	set r to (display dialog q default answer default_input)'s text returned
	if (count r) is not 0 then
		tell r to repeat with i from (count paragraphs) to 1 by -1
			if (count paragraph i) is not 0 then
				return text 1 thru paragraph i
			end if
		end repeat
	end if
	""
end jot_dialog

tell me to activate
set answer to jot_dialog for {"Jot:"}
set answer to replace_chars(answer, "'", "")
set answer to replace_chars(answer, ASCII character 13, ASCII character 10)

do shell script "echo '\n# " & answer & "' >> ~/Dropbox/notes/reference.txt"
