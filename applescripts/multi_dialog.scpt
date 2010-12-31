-- source: http://macscripter.net/viewtopic.php?id=14995

on multi_dialog for q given listing:l
	tell q as list
		set {a, b, c} to {{}, beginning, count}
		set v to b's class is integer
		if v then set {c, v, q} to {b, b is 0, rest}
	end tell
	if v then set c to 30
	repeat c times
		set a's end to ""
	end repeat
	set {d, text item delimiters} to {text item delimiters, return}
	set {q, a, text item delimiters} to {q as string, a as string, d}
	set r to (display dialog q default answer a)'s text returned
	if (count r) is not 0 then
		if not v then tell r & a
			if l then return paragraphs 1 thru c
			return text 1 thru paragraph c
		end tell
		tell r to repeat with i from (count paragraphs) to 1 by -1
			if (count paragraph i) is not 0 then
				if l then return paragraphs 1 thru i
				return text 1 thru paragraph i
			end if
		end repeat
	end if
	if l then return {}
	""
end multi_dialog

--------------------------
-- demonstration --
--------------------------

property demo_list : {"1] Name: {items: 2, length: fixed, output: list}", ¬
	"2] Address: {items: 3, length: fixed, output: list}", ¬
	"3] Reasons: {items: 6, length: fixed, output: list}", ¬
	"4] ToDo List: {items: ?, length: variable, output: text}", ¬
	"5] Standard: {items: 1, length: fixed, output: text}"}

property d : demo_list's item 1

tell (choose from list demo_list default items d with prompt "Choose a multi-dialog demonstration:")
	if it is false then error number -128
	set d to it
	set i to item 1's item 1 as integer
end tell

-----------------------------
-- syntax examples --
-----------------------------

if i is 1 then
	multi_dialog for {"• What is your first name?", "• And your last name?"} with listing
else if i is 2 then
	multi_dialog for {3, "Please enter your:", "", "1: house number & street name", "2: city/area", "3: zip code"} with listing
else if i is 3 then
	multi_dialog for {6, "List up to six reasons to be cheerful:"} with listing
else if i is 4 then
	multi_dialog for {0, "To Do list for " & (current date)'s weekday & ":"} without listing
else
	multi_dialog for "Did you *really* just want a standard dialog?" without listing
end if
