FROM php:7.4-alpine

LABEL "com.github.actions.name"="OSKAR-PHP-CS-Fixer"
LABEL "com.github.actions.description"="check php files"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/oskarstark/php-cs-fixer-ga"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Oskar Stark <oskarstark@googlemail.com>"

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O php-cs-fixer \
    && chmod a+x php-cs-fixer \
    && mv php-cs-fixer /usr/local/bin/php-cs-fixer

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
