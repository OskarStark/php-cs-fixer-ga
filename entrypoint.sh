#!/bin/sh -l

set -e

NEUTRAL_EXIT_CODE=0

if [ "GITHUB_EVENT_NAME" -eq "issue_comment" ]; then
  (jq -r ".comment.body" "$GITHUB_EVENT_PATH" | grep -Fq "/php-cs-fixer")
  COMMENT_KEYWORD_FOUND=$?

  if [ "$COMMENT_KEYWORD_FOUND" -eq 0 ]; then
    sh -c "/usr/local/bin/php-cs-fixer fix $*"
    
    if [[ -z "$GITHUB_TOKEN" ]]; then
      echo "Set the GITHUB_TOKEN env variable."
      exit 1
    fi

    # skip if not a PR
    echo "Checking if issue is a pull request..."
    (jq -r ".issue.pull_request.url" "$GITHUB_EVENT_PATH") || exit $NEUTRAL_EXIT_CODE

    git config user.name "${GITHUB_ACTOR}"
    git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

    git commit --all --message="Automatic codestyle fixes using PHP-CS-Fixer by GithubAction"
    git push -u origin HEAD
  fi
else
  sh -c "/usr/local/bin/php-cs-fixer fix --dry-run $*"
fi
