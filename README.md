# Rdv

Write plain text and export to Github issues without too much overhead.

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

The file structure needed to be converted is the following :

```text
Newsletter :
  - Design newsletter template @vala :
    * Do this
    * Do that
    * etc.
  - Other issue with labels
    Do something not being in a list ...

    blah...
    | tags | at | the | end

Other Theme :
  -> Issue with a preceding arrow
    Issue content, can be anything ...
    | tag it | here
```

What matters :
* Structure depends on indentation, so Theme / Issue / Content should be respected
* Collaborator assignment should be at the end of the issue title
* Labels list should be at the end of the issue content, beginning with a pipe (|) and each label separated by a pipe too

What is optional :
* Collaborator assignment is optional
* Tags are optional
* Dashes or arrows at the beginning of the Theme or the Issue title will be stripped
* Colon at the end of Theme or Issue title will be stripped
* Issue content can contain any Github Issue supported markup

