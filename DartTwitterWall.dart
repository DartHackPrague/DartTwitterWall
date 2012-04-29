#library('twitter_wall');

#import("TwitterApi.dart");
#import('dart:io');
#import('dart:core');

void main() {
  Options options = new Options();
  try {
    validateInput( options.arguments );
    String hashTag = options.arguments[0];

    printTweets( hashTag );
    Timer timer = new Timer.repeating( 15000, (Timer timer) {
      printTweets( hashTag );
    });

  } catch ( IllegalArgumentException e ) {
    print( "Usage: dart DartTwitterWall.dart hashtag" );
  }
}

void validateInput( List options ) {
  if ( options.length < 1 ) {
    throw new IllegalArgumentException();
  }
}

void printTweets( String hashTag ) {
  TwitterApi api = new TwitterApi(searchQuery:hashTag);
  int tweetHeight = 4;
  int terminalWidth = 139;
  int terminalHeight = 28;

  api.getTweets(max:7).then( ( List<Tweet> tweets ) {
    printHeader();

    int remainingLength = 24;
    print( repeat(" ", 20) + "." + repeat( "-", 60 ) + "." );
    print( repeat(" ", 20) + '|  NOW: ' + new Date.now() + "  |  #"
      + hashTag + repeat( " ", remainingLength - hashTag.length ) + "|" );
    print( repeat(" ", 20) + "\\" + repeat( "-", 60 ) + "/\n" );
    
    int i = 1;
    for ( Tweet tweet in tweets ) {
      print( tweet.text );
      print( "-- \n @" + tweet.userName + ' ' + tweet.timeAgo );
      if ( i < tweets.length ) {
        print( '\n' );
      }
      i++;
    }

    print( repeat( "\n", terminalHeight - tweetHeight * tweets.length ) );
  });
}

void printHeader() {
  print( @"""  ________                 __ ___________       .__  __    __                __      __        .__  .__   
  \______ \ _____ ________/  |\__    ___/_  _  _|__|/  |__/  |_  ___________/  \    /  \_____  |  | |  |  
   |    |  \\__  \\_  __ \   __\|    |  \ \/ \/ /  \   __\   __\/ __ \_  __ \   \/\/   /\__  \ |  | |  |  
   |    `   \/ __ \|  | \/|  |  |    |   \     /|  ||  |  |  | \  ___/|  | \/\        /  / __ \|  |_|  |__
  /_______  (____  /__|   |__|  |____|    \/\_/ |__||__|  |__|  \___  >__|    \__/\  /  (____  /____/____/
          \/     \/                                                 \/             \/        \/           """ );
}

String repeat( String char, int lines ) {
  String wholeString = '';
  for(int i = 0; i <= lines; i++) {
    wholeString += char;
  }
  return wholeString;
}
