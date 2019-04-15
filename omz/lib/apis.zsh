
############
#  GITHUB  #
############
get_repos_org(){
  #for i in {1..15};do curl -G "https://api.github.com/orgs/google/repos?page=$i&per_page=100" > google_page_$i.json;sleep 5;done
  local org
  local page
  while getopts ':p:o:' arg; do
    case $arg in
      o) org=$OPTARG;;
      p) page=$OPTARG;;
    esac
  done
  echoe "opts page=$page org=$org"

  curl -G "https://api.github.com/orgs/$org/repos?page=$page&per_page=100"
}

list_repo_containing_search(){
  #TODO need to edit function
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo by user
  # curl -G 'https://api.github.com/users/mohitmun/repos?page=3&per_page=100'
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo by org
  # curl -G 'https://api.github.com/orgs/google/repos?page=3&per_page=100'
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo info
  # curl -G 'https://api.github.com/repo/username/reponame'
  # == == == == == == == == == == == == == == == == == == == ==
  # starred repo time
  # curl_github -G 'https://api.github.com/users/mohitmun/starred' -H 'Accept: application/vnd.github.v3.star+json'
  #
  # get_all_pr
  # https://api.github.com/repos/mohitmun/:repo/pulls?state=all
  for NUM in `seq 16`; do
    curl "https://github.com/search?p=$GPAGE&q=my_query&type=Code" --compressed > github$GPAGE;
    cat github$NUM | pup "#code_search_results > div.code-list a.text-bold text{}" >> searchlist;
  done
  uniq searchlist > searchlistuniq
  while read repo;
    do curl "https://api.github.com/repos/"$repo > `echo $repo | tr '/' '-'` 
    sleep 2
  done < searchlistuniq
  cat * | jq -r '[.full_name, .stargazers_count, .description] | @csv' > repos.csv
}

############
#  POCKET  #
############
add_to_pocket(){
  json_string=$(jo url=$1 tags=$2 consumer_key=$POCKET_CONSUMER_KEY access_token=$POCKET_TOKEN)
  jcurl 'https://getpocket.com/v3/add/' --data-binary $json_string
}

get_pocket(){
  json_string=$(jo consumer_key=$POCKET_CONSUMER_KEY access_token=$POCKET_TOKEN)
  jcurl -X GET 'https://getpocket.com/v3/get/' --data-binary $json_string
}

get_suggested(){

  json_string=$(jo version=2 locale_lang=en consumer_key=$POCKET_CONSUMER_KEY access_token=$POCKET_TOKEN resolved_id=$1 count=3)
  echo $json_string
  jcurl -X GET 'https://getpocket.com/v3/getSuggestedItems/' --data-binary $json_string
  #jcurl 'https://getpocket.com/v3/getSuggestedItems/' -H 'x-accept: application/json' -H 'Origin: chrome-extension://niloccemoadcdkdjlinkgdfekeahmflj' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36' -H 'content-type: application/json' --data-binary '{"resolved_id":"331883344","version":2,"locale_lang":"en","count":3,"access_token":"a539f6e3-913a-1763-690b-c36388","consumer_key":"7035-d3382df43fe0195174c42f9c"}' --compressed

}
add_tags(){
  curl 'https://getpocket.com/v3/send/' -H 'content-type: application/json' --data-binary '{"actions":[{"action":"tags_add","item_id":"790774152","tags":["file_system"]}],"access_token":"'"$POCKET_TOKEN"'","consumer_key":"'"$POCKET_CONSUMER_KEY"'"}' --compressed
}


##########
#  UBER  #
##########
current_ride(){
  curl -H "Authorization: Bearer $UBER_TOKEN" -H 'Accept-Language: en_US' -H 'Content-Type: application/json' 'https://api.uber.com/v1.2/requests/current'
}

#############
#  Twitter  #
#############
get_twitter(){
  max_position=1096412606443724801
  URL="https://twitter.com/i/profiles/show/climagic/timeline/tweets?include_available_features=1&include_entities=1&max_position=$max_position&reset_error_state=false"
  jq -r .items_html /Users/mohit/Downloads/json.json  | pup ".js-tweet-text-container text{}"
}
