workflow "Main" {
  on = "push"
  resolves = ["PHP-CS-Fixer"]
}

action "PHP-CS-Fixer" {
  uses = "docker://oskarstark/php-cs-fixer-ga"
  args = "--diff --dry-run"
}
