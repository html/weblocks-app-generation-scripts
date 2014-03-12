# version 0.0.1
function add-quicklisp-submodule(){
  REPO_NAME="`echo "$1" | grep -o "\([^/]\+\?\)\.git" | sed -e s/.git//`"
  CMD="git submodule add $1 ./lib/$REPO_NAME"
  echo $CMD
  git submodule add "$1" "./lib/$REPO_NAME"
}

function install-weblocks-cms(){
  add-quicklisp-submodule https://github.com/html/weblocks-cms.git
  add-quicklisp-submodule https://github.com/html/weblocks-bootstrap-typeahead-presentation.git
  add-quicklisp-submodule https://github.com/html/weblocks-bootstrap-date-entry-presentation.git
  add-quicklisp-submodule https://github.com/html/weblocks-ajax-file-upload-presentation.git
  BB="\e[1m"
  CB="\e[21m"

  echo -e "Please"
  echo -e "* add $BB:weblocks-cms$CB dependency to your .asd file";
  echo -e "* add $BB(weblocks-cms:regenerate-model-classes)$CB somewhere to project file to be run once during project start";
  echo -e "* add $BB(start-webapp 'weblocks-cms:weblocks-cms)$CB into project start app function";
  echo -e "* start server, navigate to $BB/super-admin$CB url and begin to work. ${BB}Happy hacking$CB !";
}
