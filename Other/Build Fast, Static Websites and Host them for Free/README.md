# [Build Fast, Static Websites and Host them for Free](https://youtu.be/kiL7xoCNrgQ)

Create a hugo site

```
hugo new site gatherer
cd gatherer
code . 
hugo server
```

Add a hugo theme

```
git init 
git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder
```

Set the hugo theme in `config.toml`

```
theme = "hugo-coder"
```

A full example of the `config.toml`

```
baseURL = "http://www.example.com"
title = "Adam Driscoll"
theme = "hugo-coder"
languageCode = "en"
defaultContentLanguage = "en"
paginate = 20
pygmentsStyle = "bw"
pygmentsCodeFences = true
pygmentsCodeFencesGuessSyntax = true
enableEmoji = true
publishDir = "docs"

[params]
author = "Adam Driscoll"
# license = '<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA-4.0</a>'
description = "Adam Driscoll's personal website"
keywords = "blog,developer,personal"
info = ["Full Stack DevOps", "Magician"]
avatarURL = "https://avatars.githubusercontent.com/u/1256531?v=4"
#gravatar = "adam@ironmansoftware.com"
dateFormat = "January 2, 2006"
since = 2019

[taxonomies]
category = "categories"
series = "series"
tag = "tags"
author = "authors"

[[params.social]]
name = "Github"
icon = "fa fa-2x fa-github"
weight = 1
url = "https://github.com/johndoe/"

[[params.social]]
name = "Gitlab"
icon = "fa fa-2x fa-gitlab"
weight = 2
url = "https://gitlab.com/johndoe/"

[[params.social]]
name = "Twitter"
icon = "fa fa-2x fa-twitter"
weight = 3
url = "https://twitter.com/johndoe/"

[[params.social]]
name = "LinkedIn"
icon = "fa fa-2x fa-linkedin"
weight = 4
url = "https://www.linkedin.com/in/johndoe/"

[[params.social]]
name = "Medium"
icon = "fa fa-2x fa-medium"
weight = 5
url = "https://medium.com/@johndoe"

[[params.social]]
name = "RSS"
icon = "fa fa-2x fa-rss"
weight = 6
url = "https://myhugosite.com/index.xml"
rel = "alternate"
type = "application/rss+xml"

[languages.en]
languageName = ":uk:"

[[languages.en.menu.main]]
name = "About"
weight = 1
url = "about/"

[[languages.en.menu.main]]
name = "Blog"
weight = 2
url = "posts/"

[[languages.en.menu.main]]
name = "Projects"
weight = 3
url = "projects/"

[[languages.en.menu.main]]
name = "Contact me"
weight = 5
url = "contact/"
```

Create a hugo post and build the site

```
hugo new posts/my-first-post.md
hugo -D 
```