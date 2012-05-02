DartTwitterWall
===============

A working CLI Twitter Wall implementation by team of Organizers at Google Global Dart Hackathon Prague (created in order to replace a graphical in-browser one, which is not so much geeky, because we need to use it without XWindows on a Linux machine ;-)...)

You can use the minimal Dart Twitter API client like this:

    #import('TwitterApi.dart');
    
    ...

    void main() {
      // set up the API object, make it search for #fail tweets
      TwitterApi api = new TwitterApi(searchQuery:"fail"); 

      // run the async request
      api.getTweets(max:10)
      .then((List<Tweet> tweets) {
          for (Tweet tweet in tweets) {
            print("@${tweet.userName}");
            print(tweet.text);
            print("-- tweeted ${tweet.timeAgo}");
          }
          api.close();
      });
    }

Enjoy!
