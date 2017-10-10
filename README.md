GradingScripts
graderSetterUpperM
Requirements: 
 - Perl is installed
 - You are a grader with access to the appropriate folders and files

How to use:

Enter your username into the $myID variable,
Enter the current assignment and it's .score directory into the $currentAsg and $asgDir variables accordingly.
Populate the @toBeCopied array with regexes for matching test files and scripts that are to be copied.
Run the script
What it does: Goes through the class' admin folder looking for the list of students whose assignments are to be
graded by you (assigned to your userid), copies down the userids assigned to you and then goes into the .score 
directory to copy all files that match the patterns given in the @toBeCopied array.

Possible Improvements: Instead of matching regexes, just copy everything that's not a SCORE or SCORE.pair file.
