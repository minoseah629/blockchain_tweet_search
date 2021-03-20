$twapi ='https://api.twitter.com/2/tweets/search/all'
$query = 'blockchain lang:en'
$start_time ='start_time=2020-01-01T00:00:00Z'
$end_time = 'end_time=2020-12-31T00:00:00Z'
$range = $start_time + '&' + $end_time
$add ='max_results=100&tweet.fields=created_at&expansions=author_id'
$url = "$($twapi)?query=$($query)&$($range)&$($add)"

$headers = [System.Collections.Generic.Dictionary[string,string]]::new()
$headers.Add("Authorization", 'Bearer '+$($Env:BearerToken))

$i = 0
$tweetlist = [System.Collections.Generic.List[System.Tuple[string,string,System.DateTime]]]::new()

while ($i -ne 1000)
{
    new-variable -name data$i
    set-variable -name data$i -value (Invoke-RestMethod -Uri $url -Headers $headers) 
    $inputData = Get-Variable -Name data$i -ValueOnly
    $inputData.data | ForEach-Object{ $tweetlist.Add([System.Tuple]::Create($_.author_id,$_.text,$_.created_at)) }
    $next_token = $inputData.meta.next_token

    $token = "&next_token=$($next_token)"
    if ($i -ge 1)
    {
        $url = $url.Replace($beforeToken,"")
    }
    
    $url=$url+$token
    $beforeToken = $token
    $i++
    [System.Threading.Thread]::Sleep(5000)
} 

$userlist | ConvertTo-Json | Out-File tweetsearchbulk.json
