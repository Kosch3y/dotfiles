function prepend-prefix --description "prepends given prefix to the commandline."
  if not commandline | string length -q
    commandline -r $history[1]
  end
  
  set -l prefix $argv[1]
  set -l prefix_len (string length $prefix)
  set -l cursor (commandline -C)
  commandline -C 0
  commandline -i $prefix
  commandline -C (math $cursor + $prefix_len)
  commandline -f repaint
end
