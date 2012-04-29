#library('twitter_wall');

#import("TwitterApi.dart");
#import('dart:io');
#import('dart:core');

void main() {
  TwitterApi api = new TwitterApi();
  Timer timer = new Timer.repeating( 250, (Timer timer) {
    api.getTweets().then( ( List<Tweet> tweets ) {
      for ( Tweet tweet in tweets ) {
        print( tweet.text );
      }
    });
    
    print( new Date.now() );
    repeat( "\n", 12 );
  });
}

void repeat( String char, int lines ) {
  for(int i = 0; i <= lines; i++) {
    print( char );
  }
}
