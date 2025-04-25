#get ad all enabled users job titles and  group them by count/number:
Get-ADUser -Filter 'Enabled -eq $true' -Properties Title |     Where-Object { $_.Title } |     Group-Object -Property Title |     Sort-Object Count -Descending |     Select-Object Name, Count

#get all users with specific job title:
Get-ADUser -Filter 'Title -eq "CIO"' -Properties Title | Select-Object Name, SamAccountName, Title

#List departments sort by numbers
Get-ADUser -Filter {Enabled -eq $true} -Properties Department |     Where-Object { $_.Department -ne $null } |     Group-Object Department |     Select-Object Name, Count |     Sort-Object Count -Descending 