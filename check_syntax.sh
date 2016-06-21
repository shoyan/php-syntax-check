#!/bin/bash

echo "Start"
LIST=`git diff --name-only origin/master | grep '.php'`
if [ -z $LIST ]; then
    echo "Success"
    exit 0
fi

vendor/bin/phpcs index.php --standard=PSR2 --report=checkstyle \
 | bundle exec checkstyle_filter-git diff origin/master \
 | bundle exec saddler report \
   --require saddler/reporter/github \
   --reporter Saddler::Reporter::Github::PullRequestReviewComment
