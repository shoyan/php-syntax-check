#!/bin/bash

echo "Start"
LIST=`git diff --name-only origin/master | grep '.php'`
if [ -z $LIST ]; then
    echo "Success"
    exit 0
fi

gem install checkstyle_filter-git

vendor/bin/phpcs index.php --standard=PSR2 --report=checkstyle \
 | checkstyle_filter-git diff origin/master
