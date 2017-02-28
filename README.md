# Specifications

Specifications for the MIP platform

## Modifications and contributions to the site

The site is built from Markdown content using [Hugo](http://gohugo.io/) to generate the HTML code.

Development is done on the __master__ branch of this repository, HTML pages should go to the __gh-pages__ branch.

To get started, type the following in a command line. You will need Git version 2.7 or better and Docker.

```
  git clone git@github.com:HBPMedical/specifications
  cd specifications
  ./after-git-clone.sh
```

This will create the folder specifications.pages that contains the HTML pages to be published on Github.io.

Use the following command to run Hugo as a local server, available on [localhost:1313](http://localhost:1313/).
Any change you do on Markdown files will be updated immediately in the local site.

```
  ./run.sh
```

Commit regularly your changes, ideally indicating what what changed, for example

```
  git commit -a -m "Add new User Documentation page"
```

When you are ready to publish, follow those steps:

```
  # commit all your work
  git add --all .
  git commit -m "<My changes>"
  # push the changes on the master branch
  git push
  # build the site
  ./build.sh
  # publish the new site
  cd ../specifications.pages
  git add --all .
  git commit -m "<My changes>"
  git push
```

Done.

## Online editing

You can use the following services to contribute to the site:

* [Appernetic](https://appernetic.io/)
  * [Collaborating and working with Hugo themes](https://blog.appernetic.io/2016/02/18/collaborating-and-working-with-hugo-themes/)
  * [Manage your website images in the cloud](https://blog.appernetic.io/2016/03/09/manage-your-web-site-images-in-the-cloud/)
  * [Why use a static website generator?](https://blog.appernetic.io/2016/02/10/why-use-a-static-website-generator/)
  * [Gitter channel](https://gitter.im/appernetic/issues/) for support
* [Forestry](https://forestry.io/)

Please be careful when publishing your changes back to Github.

