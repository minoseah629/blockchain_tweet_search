#$users = get-content ~/Desktop/Untitled.json |ConvertFrom-Json

$twapi ='https://api.twitter.com/2/users'
$headers = [System.Collections.Generic.Dictionary[string,string]]::new()
$headers.Add("Authorization", 'Bearer '+$($Env:BearerToken))
$userlist = [System.Collections.Generic.List[Tuple[Int64, string,PSCustomObject]]]::new()

$users | ForEach-Object {
    $url = "$($twapi)/$($_.authorid)?user.fields=public_metrics"
    $user = (Invoke-RestMethod -Uri $url -Headers $headers) 

    $userlist.Add([System.Tuple]::Create([System.Convert]::ToInt64($user.data.id), $user.data.username, $user.data.public_metrics))
    [System.Threading.Thread]::Sleep(4000)
}
