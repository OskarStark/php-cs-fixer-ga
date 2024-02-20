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
    - uses: actions/checkout@v3
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
    - uses: actions/checkout@v3
    - name: PHP-CS-Fixer
      uses: docker://oskarstark/php-cs-fixer-ga
+     with:
+       args: --config=.project.php_cs --diff --dry-run
```

## Usage with cache

Add `.php-cs-fixer.cache` to `.gitignore`, then:

```
on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/cache@v3
        with:
          path: .php-cs-fixer.cache
          key: ${{ runner.OS }}-${{ github.repository }}-phpcsfixer-${{ github.sha }}
          restore-keys: |
            ${{ runner.OS }}-${{ github.repository }}-phpcsfixer-

      - name: PHP-CS-Fixer
        uses: docker://oskarstark/php-cs-fixer-ga
```

**You can copy/paste the `.github/` folder (under `examples/`) to your project and that's all!**

## Usage with only changed files

It is also possible to run PHP-CS-Fixer just on your changed files. To achieve this, you can use the [`tj-actions/changed-files`](https://github.com/tj-actions/changed-files) action to retrieve the changed files and subsequently use the result to create extra arguments with `---path-mode=intersection`.

```
on: [push, pull_request]
name: Main
jobs:
  php-cs-fixer:
    name: PHP-CS-Fixer
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Get changed files
        id: changed-files
        uses: tj-actions/changed-files@v38

      - name: Get extra arguments for PHP-CS-Fixer
        id: phpcs-intersection
        run: |
          CHANGED_FILES=$(echo "${{ steps.changed-files.outputs.all_changed_files }}" | tr ' ' '\n')
          if ! echo "${CHANGED_FILES}" | grep -qE "^(\\.php-cs-fixer(\\.dist)?\\.php|composer\\.lock)$"; then EXTRA_ARGS=$(printf -- '--path-mode=intersection\n--\n%s' "${CHANGED_FILES}"); else EXTRA_ARGS=''; fi
          echo "PHPCS_EXTRA_ARGS<<EOF" >> $GITHUB_ENV
          echo "$EXTRA_ARGS" >> $GITHUB_ENV
          echo "EOF" >> $GITHUB_ENV

      - name: PHP-CS-Fixer
        uses: docker://oskarstark/php-cs-fixer-ga
        with:
          args: --config=.php-cs-fixer.dist.php -v --dry-run --stop-on-violation --using-cache=no ${{ env.PHPCS_EXTRA_ARGS }}"
```

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
