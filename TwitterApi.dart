#library("twitterApi");

#import('dart:io');
#import('dart:uri');
#import('dart:json');

class Tweet {
  String userName;
  String text;
  String createdAt;

}

class TwitterApi {

  List<Tweet> getTweets([int max=5]) {
    Tweet tw = new Tweet();
    tw.userName = "filiphracek";
    tw.text = "This is a mock tweet";
    tw.createdAt = "Sunday....";

    return [tw];
  }

  void printRecentTweets(HttpClient client) {


    Uri streamUrl = new Uri.fromString(
      'http://search.twitter.com/search.json?q=darthack12'
    );

    HttpClientConnection conn = client.getUrl(streamUrl);

    List<int> buffer = new List();

    InputStream inputStream;
    StringInputStream lines;

    conn.onResponse = (HttpClientResponse response) {
      inputStream = response.inputStream;
      lines = new StringInputStream( inputStream );

      lines.onLine = () {
        String stream = lines.readLine();
        Map<String,Dynamic> output = JSON.parse( stream );

        List<Map<String,Dynamic>> results = output["results"];

        for ( int i = 0; i < 5; i++) {
          print( results[i]['text'] + '\n from ' +
            results[i]['from_user_name'] + ' at ' + results[i]["created_at"] +
            "\n-------------------");
        }

        inputStream.close();
      };
    };


  }

  void init() {
    HttpClient client = new HttpClient();


    printRecentTweets(client);
    client.shutdown();
  }


}
