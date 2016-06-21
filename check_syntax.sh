#!/bin/bash

echo "Start"
LIST=`git diff --name-only origin/master | grep '.php'`

if [ -z "$LIST" ]; then
    echo "PHP file not changed."
    exit 0
fi


if [ -n "$CI_PULL_REQUESTS" ]; then
    git diff --name-only origin/master \
        | grep '.php' \
        | xargs vendor/bin/phpcs -n --standard=PSR2 --report=checkstyle \
        | bundle exec checkstyle_filter-git diff origin/master \
        | bundle exec saddler report \
        --require saddler/reporter/github \
        --reporter Saddler::Reporter::Github::PullRequestReviewComment
fi
