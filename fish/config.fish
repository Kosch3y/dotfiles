if status is-interactive
    # Commands to run in interactive sessions can go here

    # set -g fish_key_bindings fish_vi_key_bindings
    fish_vi_key_bindings
    set -g fish_sequence_key_delay_ms 300

    bind \en "nvim ."
    bind --mode insert \en "nvim ."
    bind \em "prepend-prefix 'mn '"
    bind --mode insert \em "prepend-prefix 'mn '"
    bind \e\  "prepend-prefix ' '"
    bind --mode insert \e\  "prepend-prefix ' '"
    
    bind --mode insert --sets-mode default jk repaint-mode

    bind --mode insert \ch backward-char
    bind --mode insert \cj down-or-search
    bind --mode insert \ck up-or-search
    bind --mode insert \cl forward-char
end
