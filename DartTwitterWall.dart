#source("TwitterApi.dart");

void main() {
  TwitterApi api = new TwitterApi();
  List<Tweet> tweets = api.getTweets(max:5);
}
