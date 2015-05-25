chatbot
=======

An extensible chatbot written in rust.

[![Circle CI](https://circleci.com/gh/jwilm/chatbot.svg?style=svg)](https://circleci.com/gh/jwilm/chatbot)

## About

The construction is inspired by Hubot's extensibility. There is an ever-growing
list of [service adapters][] and [message handlers][] as part of the project.

To get started, you might make a `main` function that looks like the following.
Once you get that running, check out the [documentation][] to add more packaged
[message handlers][] or write your own.

```rust
#[macro_use(handler)]
extern crate chatbot;

use chatbot::Chatbot;
use chatbot::adapter::CliAdapter;
use chatbot::handler::BasicMessageHandler;

fn main() {
    let mut bot = Chatbot::new();

    let echo = handler!("EchoHandler", r"echo .+", |msg| {
        msg.to_owned()
    });

    bot.add_handler(echo);
    bot.add_adapter(CliAdapter::new());

    bot.run();
}
```

## Plans

My immediate priority list looks something like the following.

1. Clean up slack adapter implementation
2. Add a `RobotBrain` trait a `RedisBrain` implementation, and some sort of
   structured text (json/toml/yaml? tbd). The brain will be passed into to the
   handlers' `handle` method.
3. Add more message handlers.
    - GitHub issue poster
    - countdowns
    - simple key-value store for remembering things in chat
4. [IRC Chat Adapter](https://github.com/jwilm/chatbot/issues/1)

There are some other miscellaneous items in the [issue tracker][] as well.

I can imagine a time when the handlers should get moved out into their own
repository so their development can continue independently. The API needs to
stabilize before that's possible.

## Contributing

Contributions are very welcome on this project. To get started, fork the repo
and clone it locally. You should be able to just do `cargo run` (assuming you're
on the nightlies) and get a working echo handler on the command line. If you
want to run the test program using the Slack adapter, do
`cargo run -- --adapter slack`.

[service adapters]: http://chatbot.rs/chatbot/adapter/trait.ChatAdapter.html#implementors
[message handlers]: http://chatbot.rs/chatbot/handler/trait.MessageHandler.html#implementors
[documentation]: http://chatbot.rs/chatbot/
[issue tracker]: https://github.com/jwilm/chatbot/issues
[mio]: https://github.com/carllerche/mio
