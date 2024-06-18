
function yank --wraps=/usr/bin/yank
  /usr/bin/yank $argv -- xsel --clipboard
end
