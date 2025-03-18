#!/usr/bin/env julia

using Dates

function main()
  ENV["TZ"] = "UTC"
  (time_path, _) = mktemp()
  set_time(time_path)
  cmd = make_cmd(time_path)

  try
    run(cmd)
  catch
    exit(1)
  end
end

function get_env(time_path)
  env = copy(ENV)
  env["LD_PRELOAD"] = "/usr/lib/faketime/libfaketime.so.1"
  env["FAKETIME_DONT_RESET"] = "1"
  env["FAKETIME"] = "%"
  env["FAKETIME_UPDATE_TIMESTAMP_FILE"] = "1"
  env["FAKETIME_FOLLOW_FILE"] = time_path

  env
end

function make_cmd(time_path)
  if isfile("/etc/NIXOS")
    time = readchomp(open(`stat -c %y $time_path`))
    `faketime $time $ARGS`
  else
    env = get_env(time_path)
    cmd = setenv(`$ARGS`, env)
    cmd
  end
end

function set_time(time_path)
  date_time = Dates.now(UTC) |>
    dt -> floor(dt, Day) |>
    dt -> Dates.format(dt, "yymmddHHMM.SS")

  run(`touch -t $date_time $time_path`)
end

main()
