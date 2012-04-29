#library('twitter_wall');

#import("TwitterApi.dart");

void main() {
  TwitterApi api = new TwitterApi();

  api.getTweets().then((List<Tweet> tweets) {


  });
}
