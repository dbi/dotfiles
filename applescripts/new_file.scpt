-- create the new file
--activate
try
  tell application "Finder" to set the this_folder to (folder of the front window) as alias
on error -- no open folder windows
  set the this_folder to path to desktop folder as alias
end try

--set thefilename to text returned of (display dialog "Create file named:" default answer "filename.txt")
--set thefullpath to POSIX path of this_folder & thefilename
set thefullpath to POSIX path of this_folder & "new_file.txt" -- TODO: if file is taken then append number
do shell script "touch \"" & thefullpath & "\"" -- TODO: use the applescript way

-- select the new file
set newPath to (the POSIX path of thefullpath)
set newerPath to (POSIX file newPath)

tell application "Finder"
  activate
  reveal newerPath
  select newerPath
end tell

delay 0.05 -- TODO: instead check if file is selected
tell application "System Events" to key code 36
