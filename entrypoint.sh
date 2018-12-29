#!/bin/sh -l

sh -c "ls -la"

sh -c "/usr/local/bin/php-cs-fixer fix $*"

