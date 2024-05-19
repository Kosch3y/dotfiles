#!/usr/bin/env julia

dependencies = ["checkupdates", "yay", "arch-audit"]

function main()
  updates = (
    arch=count_updates(`checkupdates`),
    aur=count_updates(`yay -Qum`),
    security=count_updates(`arch-audit -u`))
  security_flag = updates.security != 0 ? "" : ""
  println("$(updates.arch)+$(updates.aur) $(security_flag)")
end

function count_updates(cmd)
  proc = open(cmd)
  out = readchomp(proc)
  if proc.exitcode == 0
    out |>
      o -> split(o, "\n") |>
      l -> filter(!isempty, l) |>
      length
  elseif proc.exitcode == 2
    0
  else
    error("unexpected error in $cmd \n$out")
  end
end

try
  main()
catch e
  println("???")
end
