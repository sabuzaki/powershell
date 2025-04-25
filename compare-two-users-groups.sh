# Replace with the actual usernames or email addresses
$user1 = "user1@example.ie"
$user2 = "mamkaiiv@exmaple.ie"

# Get all distribution groups
$allGroups = Get-DistributionGroup

# Get groups for each user
$user1Groups = $allGroups | Where-Object { (Get-DistributionGroupMember $_.Identity | Where-Object {$_.PrimarySmtpAddress -eq $user1}) }
$user2Groups = $allGroups | Where-Object { (Get-DistributionGroupMember $_.Identity | Where-Object {$_.PrimarySmtpAddress -eq $user2}) }

# Extract group names
$user1GroupNames = $user1Groups.Name
$user2GroupNames = $user2Groups.Name

# Compare: groups that user2 is in, but user1 is not
$groupsOnlyUser2 = $user2GroupNames | Where-Object { $_ -notin $user1GroupNames }

# Output result
Write-Host "Groups that $user2 is in, but $user1 is not:" -ForegroundColor Cyan
$groupsOnlyUser2