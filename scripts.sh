# version 0.0.2
function create-weblocks-app-repository(){
    NAME="$1"
    mkdir "$NAME";
    cd "$NAME";
    git init
    git submodule add git://github.com/html/quicklisp-app-skeleton.git .quicklisp-install
    cp .quicklisp-install/.quicklisp-version .
    echo  "(progn (ql:quickload :weblocks) (funcall (intern \"MAKE-APP\" \"WOP\") '$NAME \".\"))" | sbcl --load ".quicklisp-install/require-quicklisp"
    mv $NAME/* .
    rm -rf "$NAME"
    git add *
    function define(){ IFS='\n' read -r -d '' ${1} || true; }
    define SERVER << 'END_TEXT'
PROJECT_ROOT=`dirname $0`/../
SWANK_PORT=4005
WEBLOCKS_PORT=5555
echo "Project root: $PROJECT_ROOT"
echo "DELETING old $NAME fasl"
find $PROJECT_ROOT/src  -iname *.fasl -delete
sbcl --dynamic-space-size 2048 --userinit $PROJECT_ROOT/$NAME.sbclrc $PROJECT_ROOT $WEBLOCKS_PORT $SWANK_PORT
END_TEXT

    mkdir script;
    echo "$SERVER" | sed -e s/\$NAME/$NAME/g  > script/server;
    chmod +x script/server
    define SBCLRC << 'END_TEXT'
(load ".quicklisp-install/require-quicklisp.lisp")
(require 'asdf)
(require 'sb-posix)
(require :sb-aclrepl)
(setf sb-impl::*default-external-format* :utf-8)
(push (make-pathname :directory '(:relative "lib")) ql:*local-project-directories*)

(defvar *project-root* (pathname (nth 1 *posix-argv*)))
(defvar *port* (parse-integer (nth 2 *posix-argv*)))
(defvar *swank-port* (parse-integer (nth 3 *posix-argv*)))

(ql:quickload :trivial-features)
(ql:quickload :cffi-grovel)
(ql:quickload :firephp)
(require :bordeaux-threads)

(if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
    (setf sb-ext:*posix-argv* (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
    (when (interactive-stream-p *terminal-io*)
      (require :sb-aclrepl)
      (ql:quickload :linedit)
      (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))

(ql:quickload :cl-prevalence)
(ql:quickload :weblocks)
(ql:quickload :swank)

(swank:create-server :dont-close t :port *swank-port*)

(ql:quickload :$NAME)
($NAME:start-$NAME :port *port*)

;; sending "\\033[2J" to clear screen
(format t "~C[2J~%" #\Esc)

(format t "Welcome to weblocks~%")
(format t "Weblocks is running on port ~S, and can be access by browsing http://localhost:~S~%" *port* *port*)
(format t "Swank is running on port ~S~%" *swank-port*)
(format t "Use (quit) to exit REPL")
(in-package $NAME)

(defun quit () (sb-ext:quit))
END_TEXT
    echo "$SBCLRC" | sed -e s/\$NAME/$NAME/g > "$NAME.sbclrc";
    git add "$NAME.sbclrc"
    git add .quicklisp-version
    git add script
}

# version 0.0.2
function create-weblocks-bootstrap-app-repository(){
    NAME="$1"
    mkdir "$NAME";
    cd "$NAME";
    git init
    git submodule add git://github.com/html/quicklisp-app-skeleton.git .quicklisp-install
    cp .quicklisp-install/.quicklisp-version .
    mkdir lib
    git submodule add git://github.com/html/weblocks-twitter-bootstrap-application.git lib/weblocks-twitter-bootstrap-application
    echo  "(progn (push (make-pathname :directory '(:relative \"lib\")) ql:*local-project-directories*) (ql:quickload :weblocks-twitter-bootstrap-application) (funcall (intern \"MAKE-APPLICATION\" \"WEBLOCKS-TWITTER-BOOTSTRAP-APPLICATION\") '$NAME \".\"))" | sbcl --load ".quicklisp-install/require-quicklisp"
    mv $NAME/* .
    rm -rf "$NAME"
    git add *
    function define(){ IFS='\n' read -r -d '' ${1} || true; }
    define SERVER << 'END_TEXT'
PROJECT_ROOT=`dirname $0`/../
SWANK_PORT=4005
WEBLOCKS_PORT=5555
echo "Project root: $PROJECT_ROOT"
echo "DELETING old $NAME fasl"
find $PROJECT_ROOT/src  -iname *.fasl -delete
sbcl --dynamic-space-size 2048 --userinit $PROJECT_ROOT/$NAME.sbclrc $PROJECT_ROOT $WEBLOCKS_PORT $SWANK_PORT
END_TEXT

    mkdir script;
    echo "$SERVER" | sed -e s/\$NAME/$NAME/g  > script/server;
    chmod +x script/server
    define SBCLRC << 'END_TEXT'
(load ".quicklisp-install/require-quicklisp.lisp")
(require 'asdf)
(require 'sb-posix)
(require :sb-aclrepl)
(setf sb-impl::*default-external-format* :utf-8)
(push (make-pathname :directory '(:relative "lib")) ql:*local-project-directories*)

(defvar *project-root* (pathname (nth 1 *posix-argv*)))
(defvar *port* (parse-integer (nth 2 *posix-argv*)))
(defvar *swank-port* (parse-integer (nth 3 *posix-argv*)))

(ql:quickload :trivial-features)
(ql:quickload :cffi-grovel)
(ql:quickload :firephp)
(require :bordeaux-threads)

(if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
    (setf sb-ext:*posix-argv* (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
    (when (interactive-stream-p *terminal-io*)
      (require :sb-aclrepl)
      (ql:quickload :linedit)
      (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))

(ql:quickload :yaclml)
(ql:quickload :cl-prevalence)
(ql:quickload :weblocks)
(ql:quickload :swank)

(swank:create-server :dont-close t :port *swank-port*)

(ql:quickload :$NAME)
($NAME:start-$NAME :port *port*)

;; sending "\\033[2J" to clear screen
(format t "~C[2J~%" #\Esc)

(format t "Welcome to weblocks~%")
(format t "Weblocks is running on port ~S, and can be access by browsing http://localhost:~S~%" *port* *port*)
(format t "Swank is running on port ~S~%" *swank-port*)
(format t "Use (quit) to exit REPL")
(in-package $NAME)

(defun quit () (sb-ext:quit))
END_TEXT
    echo "$SBCLRC" | sed -e s/\$NAME/$NAME/g > "$NAME.sbclrc";
    git add "$NAME.sbclrc"

    git submodule add git://github.com/html/weblocks-jquery.git lib/weblocks-jquery
    git submodule add git://github.com/html/jquery-seq.git lib/jquery-seq
    (cd pub/scripts && ln -s ../../lib/weblocks-jquery/*.js . && ln -s ../../lib/jquery-seq/*.js .)
    git add pub/scripts/*.js
    git add .quicklisp-version
    git add script
}

