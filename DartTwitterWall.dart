#library('twitter_wall');

#import("TwitterApi.dart");
#import('dart:io');
#import('dart:core');

void main() {
  TwitterApi api = new TwitterApi();
  int tweetHeight = 4;
  int terminalWidth = 139;
  int terminalHeight = 20;
  
  Timer timer = new Timer.repeating( 1000, (Timer timer) {
    api.getTweets().then( ( List<Tweet> tweets ) {
      printHeader();
      print( 'NOW: ' + new Date.now() + "\n" );
      
      for ( Tweet tweet in tweets ) {
        print( tweet.text );
        print( '-- \n from ' + tweet.userName + ' at ' + tweet.timeAgo );
        print( '\n' );
      }
      
      print( repeat( "\n", terminalHeight - tweetHeight * tweets.length ) );
    });
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
