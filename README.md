# Testting out Grape, Backbone, and CoffeeScript together
So I've already written an extensive BackboneJS application, but that was ~1.5
years ago and I've just forgotten it all by now.  I also didn't use CoffeeScript
back then, so this is an opportunity for me to put together an example using the
pair.

Finally, I want to pursue using Grape for APIs so that's going in here as well.

## Development
Install coffee-script:

    npm install -g coffee-script

That obv. assumes you already have node installed.

Next, tell it to watch the coffee files in coffee/lib and compile them in
public/javascript:

    coffee -o public/javascript -cw coffee/lib

