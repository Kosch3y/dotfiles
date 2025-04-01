#!/usr/bin/env julia
# Usage: launchnmove.jl <app> <sway-workspace> 
# Example: launchnmove.jl librewolf 2

import JSON
using Pipe: @pipe

function main()
    length(ARGS) < 2 && error("Usage: launchnmove.jl <app> <sway-workspace>")
    app_name, workspace = ARGS[1], ARGS[2]
    @pipe `$app_name` |> detach |> run(_, wait=false)
    container_id = wait_for_window_to_appear(app_name)
    isnothing(container_id) || run(`swaymsg \[con_id=$container_id\] move to workspace $workspace`)
end

function find_container_id(app_name, node, parent)
    if node isa Dict
        if haskey(node, "class") &&
            !isnothing(node["class"]) &&
           @pipe node["class"] |> lowercase |> contains(_, app_name)
            return parent["id"]
        end

        if haskey(node, "app_id") &&
            !isnothing(node["app_id"]) &&
           @pipe node["app_id"] |> lowercase |> contains(_, app_name)
            return node["id"]
        end

        for value in values(node)
            result = find_container_id(app_name, value, node)
            isnothing(result) || return result
        end
    elseif node isa Vector
        for item in node
            result = find_container_id(app_name, item, node)
            isnothing(result) || return result
        end
    end

    nothing
end

function wait_for_window_to_appear(app_name)
    for _ in (0:100)
        sleep(0.1)
        tree = readchomp(open(`swaymsg -t get_tree`))
        tree = JSON.parse(tree)
        container_id = find_container_id(app_name, tree, nothing)
        isnothing(container_id) && continue
        return container_id
    end

    nothing
end

main()

