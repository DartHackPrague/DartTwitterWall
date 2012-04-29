#library('twitter_wall');

#import("TwitterApi.dart");

void main() {
  TwitterApi api = new TwitterApi();
  List<Tweet> tweets = api.getTweets(max:5);
}
