# Rdv

Rdv is a small utility that parses indented plain text and converts blocks to Github issues directly.

If everytime you take notes in a text editor while debriefing with a customer, you have to create 5 to 30 issues, one by one, this utility will just do the job for you !

The markup structure is quite simple, so you can easily format it while listening and speaking to someone ... 
that's the point. But one thing is that, it is still easier to write down your notes and then format them quickly 
to add labels and assignments than having to use the Github Issues UI when creating dozens of issues at the same time.

## Converter usage

Install the gem :

```bash
gem install rdv
```

Then use the provided executable to convert your `.rdv` file :

```bash
# Syntax : rdv convert <repo> <file_path>
rdv convert vala/rdv my_file.rdv
```

## Markup

The only thing Rdv needs you to do is to respect a simple markup format. Since issues are converted to Github issues, 
which support Markdown, you can write your issues content directly in Markdown too.

Here is an example :

```text
Newsletter :
  - Design newsletter template @vala :
    Need to do this to complete with customer's needs, and blah and blah
  - Install acts_as_newsletter to send the newsletter :
    Don't forget to configure mail agent too.
    | tags | at | the | end

Other Theme :
  -> Issue with a preceding arrow @vala :
    Issue content, can be anything ...
    | tag it | here
```

### The format

The structure depends on indentation :
* The first level is a theme, that will be converted to a label when parsed
* The second level is the title of the issue
* The third level contains the issue's contents, and is optional.

Some of the markup in the example is optional. For example, themes and issues titles can begin with 
a dash or an arrow (->), and can end with a colon. All those signs will be stripped before converting them to 
labels and issues.

#### Markdown

Since Github issues allows for a special Markdown in the content of the issues, Rdv doesn't modify it, 
and the markdown you wrote will automatically be converted by Github on import :

```rdv
Theme
  Issue title
    # Summary
    Do this and that with a [link](http://github.com) and some code :
    ```ruby
    puts "ruby code in an issue"
    ```
```

#### Assignment

You can assign the issues to any of the collaborators of the target repository by adding a `@user` mention at the end 
of the issue title. If the line contains a colon at the end, the mention should precede it (as in the main example above) :

```rdv
Theme
  Issue title @vala
```

#### Labels

To assign labels to an issue, you just need to end the content of the issue with a pipe (`|`) separated list of tags.
The line being inside the content, it must start with a pipe too :

```rdv
Theme
  Issue title
    Content of the issue
    | bug | users | important
```

## Contributing

If you find anything wrong or would like to improve this utility, feel free to open an issue here in this repo. 

## Licence

Licence is MIT
