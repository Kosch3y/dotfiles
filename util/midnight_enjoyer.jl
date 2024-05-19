#!/usr/bin/env julia

using Dates

function main()
  time_path = "/tmp/midnight.tmp"
  set_time(time_path)
  env = get_env(time_path)

  cmd = `$ARGS`
  cmd = setenv(cmd, env)
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
  
  # BUG?? mb related: https://github.com/wolfcw/libfaketime/issues/444 
  env["TZ"] = "UTC"

  env
end

function set_time(time_path)
  date_time = Dates.now(UTC) |>
    dt -> floor(dt, Day) |>
    dt -> Dates.format(dt, "yymmddHHMM.SS")

  run(`touch -t $date_time $time_path`)
end

main()
