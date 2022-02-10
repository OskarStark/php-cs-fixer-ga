# GitHub Action for PHP-CS-Fixer

> NOTE: If you didn't create a `.php-cs-fixer.dist.php` file, do that first before adding this workflow. An example of this file created by the creators of PHP-CS-Fixer can be found [here](https://github.com/FriendsOfPHP/PHP-CS-Fixer/blob/master/.php-cs-fixer.dist.php).

## Usage

You can use it as a GitHub Action like this:

```yaml
# .github/workflows/lint.yml

on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: PHP-CS-Fixer
      uses: docker://oskarstark/php-cs-fixer-ga
```

_To use a custom config, e.g. `--diff` and `--dry-run` options:_

```diff
# .github/workflows/lint.yml

on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: PHP-CS-Fixer
      uses: docker://oskarstark/php-cs-fixer-ga
+     with:
+       args: --config=.project.php_cs --diff --dry-run
```

**You can copy/paste the `.github/` folder (under `examples/`) to your project and that's all!**

## Docker

A Docker image is built automatically and located here:
https://hub.docker.com/r/oskarstark/php-cs-fixer-ga

You can run it in any given directory like this:

```bash
docker run --rm -it -w=/app -v ${PWD}:/app oskarstark/php-cs-fixer-ga:latest
```

## A picture is worth a thousand words

You can find a working and not working PR here:
https://github.com/OskarStark/test-php-cs-fixer-ga/pulls
