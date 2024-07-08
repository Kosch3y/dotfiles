#!/usr/bin/env julia

# This script exists to addres issue https://github.com/Alexays/Waybar/issues/350
help = "\
usage: ./please_fix_my_icon_font.jl DIRECTORY 
./please_fix_my_icon_font.jl --clear DIRECTORY\
"

icon_size = "16"
icon_color = "#a3b8d6"

function main()
  args = parse_args()
  # hopefully the script won't delete .git/
  refuse_untracked_dir(args.dir)
  (walkdir(args.dir) .|>
    ((root, dirs, files),) -> joinpath.(root, files)) |>
    to_flat -> vcat(to_flat ... ) |>
    paths -> filter(path -> contains(path, ".jsonc"), paths) .|>
    path -> fix_icon_font(path, args.is_clear)
end

function fix_icon_font(path, is_clear)
  lines = readlines(path)
  f = open(path, "w")
  lines .|>
    l -> replace(l, r"<.+>{icon}</.+>"=>"{icon}") |>
    l -> (!is_clear ? 
      replace(l, "{icon}"=>"<span font='$icon_size' rise='-1000' color='$icon_color'>{icon}</span>") :
      l) |>
    l -> println(f, l)
end

function parse_args()
  if length(ARGS) == 0
    println(help)
    exit(0)
  end
  if ARGS[1] == "--clear"
    is_clear = true
    dir = ARGS[2]
  else
    is_clear = false
    dir = ARGS[1]
  end

  (;is_clear, dir)
end

function refuse_untracked_dir(dir)
  proc = redirect_stdio(stdout=devnull, stderr=devnull) do 
    open(`git -C $dir rev-parse --is-inside-work-tree`)
  end
  wait(proc)
  if proc.exitcode != 0
    println("directory is not tracked by git repo")
    exit(1)
  end
end

main()
