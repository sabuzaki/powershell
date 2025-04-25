# allow user access mailbox1 calendar
Add-MailboxFolderPermission -Identity mailbox1@example.ie:\Calendar -User user@example.ie -AccessRights Owner

#check who has permissions to this calendar.
Get-MailboxFolderPermission -Identity mailbox1@theaa.ie:\Calendar
