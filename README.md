# About

There are two functions for application installing and one for install Weblocks CMS for application.
Each of application installing functions does next things:

* Creates git repository for app in current directory
* Adds quicklisp install script git://github.com/html/require-quicklisp.git as a submodule
* Creates app from template 
* Adds script/server and related .sbclrc file for running server
* Adds all generated files and cloned git submodules to repository, `lib/` directory is used for packages. 

`create-weblocks-app-repository` creates standard weblocks application
`create-weblocks-bootstrap-app-repository` creates weblocks application based on twitter bootstrap template from here https://github.com/html/weblocks-twitter-bootstrap-application
`install-weblocks-cms` installs additional modules on ready Weblocks application (after using `create-weblocks-...`) and gives some instructions to get Weblocks CMS work

Scripts tested only for dashed application names like "simple-app" or "another-simple-application".

# Usage 

``` bash
create-weblocks-app-repository test-app
```

or 

``` bash
create-weblocks-bootstrap-app-repository test-app
```

After generating application all you need to start it is executing script/server which loads weblocks with quicklisp and starts server.
