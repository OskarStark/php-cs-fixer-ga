# php-cs-fixer-ga
GithubAction for PHP-CS-Fixer

Usage
-----

You can use it as a Github Action like this:

_.github/rst.workflow_
```
workflow "Test" {
  on = "push"
  resolves = ["PHP-CS-Fixer"]
}

action "PHP-CS-Fixer" {
  uses = "docker://oskarstark/php-cs-fixer-ga"
  secrets = ["GITHUB_TOKEN"]
}
```

A Docker-Image is built automatically and located here:
https://cloud.docker.com/u/oskarstark/repository/docker/oskarstark/php-cs-fixer-ga

You can run it in any given directory like this:

`docker run --rm -it -v ${PWD}:/app oskarstark/php-cs-fixer-ga:latest`

