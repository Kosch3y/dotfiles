#!/usr/bin/env julia

while true
  run(`xset -b`)
  run(`setxkbmap -layout us,ru,se -option grp:lctrl_toggle -option ctrl:swapcaps`)
  sleep(5)
end
