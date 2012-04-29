#library('twitter_wall');

#import("TwitterApi.dart");
#import('dart:io');
#import('dart:core');

void main() {
  printTweets();
  Timer timer = new Timer.repeating( 5000, (Timer timer) {
    printTweets();
  });
}

void printTweets() {
  String hashTag = "darthack12";
  TwitterApi api = new TwitterApi(searchQuery:hashTag);
  int tweetHeight = 4;
  int terminalWidth = 139;
  int terminalHeight = 20;
  
  api.getTweets().then( ( List<Tweet> tweets ) {
    printHeader();
    
    int remainingLength = 24;
    print( repeat(" ", 20) + "." + repeat( "-", 60 ) + "." );
    print( repeat(" ", 20) + '|  NOW: ' + new Date.now() + "  |  #"
      + hashTag + repeat( " ", remainingLength - hashTag.length ) + "|" );
    print( repeat(" ", 20) + "\\" + repeat( "-", 60 ) + "/" );
    
    for ( Tweet tweet in tweets ) {
      print( tweet.text );
      print( '-- \n @' + tweet.userName + ' ' + tweet.timeAgo );
      print( '\n' );
    }
    
    print( repeat( "\n", terminalHeight - tweetHeight * tweets.length ) );
  });
}

void printHeader() {
  print( @"""  
  ________                 __ ___________       .__  __    __                __      __        .__  .__   
  \______ \ _____ ________/  |\__    ___/_  _  _|__|/  |__/  |_  ___________/  \    /  \_____  |  | |  |  
   |    |  \\__  \\_  __ \   __\|    |  \ \/ \/ /  \   __\   __\/ __ \_  __ \   \/\/   /\__  \ |  | |  |  
   |    `   \/ __ \|  | \/|  |  |    |   \     /|  ||  |  |  | \  ___/|  | \/\        /  / __ \|  |_|  |__
  /_______  (____  /__|   |__|  |____|    \/\_/ |__||__|  |__|  \___  >__|    \__/\  /  (____  /____/____/
          \/     \/                                                 \/             \/        \/           
""" );
}

String repeat( String char, int lines ) {
  String wholeString = '';
  for(int i = 0; i <= lines; i++) {
    wholeString += char;
  }
  return wholeString;
}
