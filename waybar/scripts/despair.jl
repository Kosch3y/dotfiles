#!/usr/bin/env julia

cmd = `journalctl --boot --priority=err --output=short --lines=9000 --quiet`
triggers = ["btrfs", "usb", "ata1", "I/O"]

function main()
  proc = open(cmd)
  out = readchomp(proc)
  if proc.exitcode == 0
    lines = out |>
      o -> split(o, "\n") |>
      ls -> filter(!isempty, ls)
    num_of_total = lines |> length
    num_of_critical = lines .|>
      lowercase |>
      ls -> filter(contains_trigger, ls) |>
      length
    probably_should_reboot_flag =
      (num_of_total > 30) || (num_of_critical > 0) ?
      " " :
      ""
    println("$num_of_total$probably_should_reboot_flag")
  else
    error()
  end
end

function contains_trigger(line)
  occursin.(triggers, line) |> splat(|)
end

try
  main()
catch e
  println("???")
end

