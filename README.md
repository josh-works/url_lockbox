## Setup for FEE URL Lockbox

It's easy to get started using/testing this repo:

```shell
# clone it down
$ git clone git@github.com:josh-works/url_lockbox.git

# cd into it
$ cd url_lockbox

# bundle install
$ bundle

# setup DB
$ rake db:create
$ rake db:migrate

# seed dev environment
$ rake db:seed

# run tests
$ rspec

# run in localhost
$ rails s
```

That's it. Enjoy your poking around of the app!


-----------------------------

# Josh Thompson's notes on end-of-mod assessment


## TDD

### What went well
Almost the entire time, I started with a feature test, then as I implemented the functionality, if model tests were appropriate, I then wrote them.

I'd make the model test pass, then work back up to the feature test.

I, personally, very much enjoy TDD and found it helpful throughout this project.

I used FactoryGirl pretty well, IMO, along with test setup methods. It's minor, but it gave me some consistency and speed when setting up a new feature test.

### What went poorly

Despite how much testing I did, there were a few places where the tests were a challenge.

First, Factory Girl and Selenium don't seem to play together well. This seems to be a known issue, and I spent a few minutes experimenting with different fixes, and couldn't get it working.

Even without using FactoryGirl, I couldn't set up my test environment well:

```ruby
# neither of these worked in Rspec/Selenium test setup
link = @user.links.new( link_data_here)
link.save

@user.links.create!( link_data_here)
```

Finally, I wasn't able to reset the link submission form correctly, so I couldn't even drive the test to manually add two links.

## Rails

### What went well

I really enjoyed all the raw rails bits of the project.

I ended up pulling lots of functionality into partials, etc, and did a little monkey patching of the link validation process.

I'm still a total newb, but rails feels comfortable to me.

I love FactoryGirl, Capybara, Pry, TDD, etc. The rails framework makes me happy.

### What didn't go well

The first day, I moved *really* slowly through the user creation/login functionality, and got tied up in link validation. (Was still having to remember how Rails worked)

I finished the first day without completely passing model tests re: URL validation, which means I started day 2 at that same spot.

I generally code slowly, though usually with good understanding of what I'm doing, but all that "move slow and understand things" went out the window by about 11a on day 2.



## AJAX Calls

### What went well

I had data going to/from the server via AJAX calls. Toggling read status, adding/editing links, etc.

### What went poorly

Processing the error messages, however... went poorly.

In certain instances I could set the HTML of my `error_messages` div with the returned errors from the AJAX call, if I "stubbed" them, but the rest of the time wasn't getting them.

I think the problem was I don't yet know well how to process the "end" of the AJAX call, and it might consider a call to be success if it "successfully" got back a status and error messages from the server.

So, I couldn't divert the logic down the error handling path, because the AJAX call wasn't registering an error. It made a call, got stuff back from the server, and was therefore happy.


## JavaScript/jQuery

### What went well

Not a ton went well... I mean, I got some basic DOM manipulation set up, but it was verbose, and not DRY. I didn't set up any `toggleReadStatus` or `filterByRead`, I had `setLinkToUnread` and `setLinkToRead` or `markAsRead` and `markAsUnread`, etc. This led to a single link item having a mis mash of attributes.

### What went poorly

I caused myself problems with the JS/jQuery interactions, because of how I was building the HTML of my link items.

I didn't realize how this hurt me until I was adding the filter functionality, but I basically was looking for (and modifying) different HTML attributes based on what I was trying to do.

For example, I was tracking:

- `link.read` (a link attribute stored in DB)
- `.read` class
- `data-link-read="true/false"` (html data attribute)

So, I had several "sources of truth" regarding the status of the link. This quickly became a lot to modify, and they got out of sync with each other.

This is an instance where a different (wiser) design decision early on would have saved me lots of time and effort.

Finally, I *still* don't know how to reset the link submission form after it gets clicked. I tried a bunch of different things, with no success.

This "clear the link" problem underscored to me how my not-yet-robust knowledge of JS/jQuery crippled some of my progress, but as soon as I improve in that knowledge, I think this entire project would have gone down quickly.

In other words, a small change in input (my knowledge) would lead to a large change in output (the successful implementation of the final.)


## The service

### What went well

Nothing. Didn't get to implement it.

### What went poorly

I don't think it would have been bad to implement, but I got bogged down in part 4 of the assessment. I only reached filtering by 1p the 2nd day, so I had a lot of functionality that I tried to implement in just a few hours. As is obvious, I didn't get much of it down.
