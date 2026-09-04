function av
    agentsview serve &
    set server_pid $last_pid

    open http://localhost:8080

    fg
end

