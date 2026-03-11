-- export_apple_contacts.applescript
-- Exports Apple Contacts to a CSV file with: First Name, Last Name, Phone, Email
--
-- Usage:
--   osascript scripts/export_apple_contacts.applescript
--
-- Output: data/exports/contacts.csv
--
-- Notes:
--   - Contacts with multiple phones/emails generate one row per combination
--   - Contacts with no phone and no email are skipped
--   - Requires Contacts access permission (prompted on first run)

set outputPath to (POSIX path of (path to home folder)) & "Documents/projects/quickies/data/exports/contacts.csv"

set csvContent to "First Name,Last Name,Phone,Email" & linefeed

tell application "Contacts"
	set allPeople to every person

	repeat with p in allPeople
		set firstName to ""
		set lastName to ""
		try
			set v to first name of p
			if v is not missing value then set firstName to v as string
		end try
		try
			set v to last name of p
			if v is not missing value then set lastName to v as string
		end try

		set phoneList to {}
		set emailList to {}

		repeat with ph in phones of p
			set v to value of ph
			if v is not missing value then set end of phoneList to v as string
		end repeat
		repeat with em in emails of p
			set v to value of em
			if v is not missing value then set end of emailList to v as string
		end repeat

		if (count of phoneList) = 0 then set phoneList to {""}
		if (count of emailList) = 0 then set emailList to {""}

		-- Skip if both are empty
		if not ((count of phoneList) = 1 and item 1 of phoneList = "" and (count of emailList) = 1 and item 1 of emailList = "") then
			repeat with ph in phoneList
				repeat with em in emailList
					set fn to my csvEscape(firstName)
					set ln to my csvEscape(lastName)
					set phStr to my csvEscape(ph as string)
					set emStr to my csvEscape(em as string)
					set csvContent to csvContent & fn & "," & ln & "," & phStr & "," & emStr & linefeed
				end repeat
			end repeat
		end if
	end repeat
end tell

-- Write file
set fileRef to open for access (POSIX file outputPath) with write permission
set eof fileRef to 0
write csvContent to fileRef
close access fileRef

log "Exported to: " & outputPath

on csvEscape(val)
	if val contains "," or val contains "\"" or val contains linefeed then
		set val to "\"" & my replaceText(val, "\"", "\"\"") & "\""
	end if
	return val
end csvEscape

on replaceText(theText, searchStr, replaceStr)
	set AppleScript's text item delimiters to searchStr
	set parts to text items of theText
	set AppleScript's text item delimiters to replaceStr
	set result to parts as string
	set AppleScript's text item delimiters to ""
	return result
end replaceText
