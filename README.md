# GithubAction for PHP-CS-Fixer

## Usage

You can use it as a Github Action like this:

_.github/workflows/lint.yml_
```
on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: PHP-CS-Fixer
      uses: docker://oskarstark/php-cs-fixer-ga
```

_to use a custom config for example, --diff and --dry-run option:_
```diff
on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: PHP-CS-Fixer
      uses: docker://oskarstark/php-cs-fixer-ga
+      with:
+        args: --config=.project.php_cs --diff --dry-run
```

**You can copy/paste the .github folder (under examples/) to your project and thats all!**

## Docker

A Docker-Image is built automatically and located here:
https://hub.docker.com/r/oskarstark/php-cs-fixer-ga

You can run it in any given directory like this:

`docker run --rm -it -w=/app -v ${PWD}:/app oskarstark/php-cs-fixer-ga:latest`

## A picture is worth a thousand words

You can find a working and not working PR here:
https://github.com/OskarStark/test-php-cs-fixer-ga/pulls
