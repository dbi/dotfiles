tell application "Finder"
  if exists Finder window 1 then
    set p to folder of Finder window 1
  else
    set p to desktop
  end if
  set f to make new file at p with properties {name:"untitled.txt"}
  if p as alias is desktop as alias then
    set selection to f
  else
    select f
  end if

  activate
end tell
tell application "System Events" to key code 36

