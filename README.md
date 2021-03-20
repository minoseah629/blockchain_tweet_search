# blockchain_tweet_search

## Introduction
This repo is targetting the Twitter Developer API - Full Archive Search.  

To use this repo, you must have a Twitter Developer Account and have an approved project for Academic Research.
https://developer.twitter.com/en/solutions/academic-research

## How to Use
1. To use this, you must have a computer that is able to run powershell.  
   -  Windows by default has Powershell 5.  Mac/Linux require Powershell Core to be installed.
   -  I personally used Powershell Core 7.2.0-preview-4 on mac
2. Establish an Environment variable call BearerToken
   - In Powershell, type $profile to show where your current user's information
   - Take the file location from $profile and open it in a text editor.  
     - You may need to create this as a new file
   - In this file, $Env:BearerToken = "Your Twitter Academic Research Bearer Token"

## Details of script
```powershell
$twapi ='https://api.twitter.com/2/tweets/search/all'
$query = 'blockchain lang:en'
$start_time ='start_time=2020-01-01T00:00:00Z'
$end_time = 'end_time=2020-12-31T00:00:00Z'
$range = $start_time + '&' + $end_time
$add ='max_results=100&tweet.fields=created_at&expansions=author_id'
$url = "$($twapi)?query=$($query)&$($range)&$($add)"
```

* $twapi is the Twitter API Base URL for Full Archive Search.
* $query is the search criteria.
  * my search is targetting blockchain tweets in English 
    * https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
* start_time and end_time are the range tweets you are searching.
  * date and time must be formatted like YYYY-MM-DDTHH:mm:ssZ. (mm is minutes and MM is month)
  * Z is Universal Time Coordinated (UTC) or London time 
* add is additional parameters described in Documentation
  * max_result can range from 10 to 500
  * tweet.fields is the desired fields from tweet like created_at (meaning date tweet was created)
    * https://developer.twitter.com/en/docs/twitter-api/fields 
  * expansion is meta data (the author of tweet)
    * https://developer.twitter.com/en/docs/twitter-api/expansions 

## Output
```jsonc
[
  {
    "Item1": "00000000001",//not in actual author_id
    "Item2": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et ma",
    "Item3": "2020-12-30T23:59:46Z",
    "Length": 3
  },
  {
    "Item1": "0000000011",
    "Item2": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et ma",
    "Item3": "2020-12-30T23:59:41Z",
    "Length": 3
  }
]
```
