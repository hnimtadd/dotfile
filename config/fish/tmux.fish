# if status is-interactive && not set -q TMUX
#     if tmux has-session -t BASE
#         tmux new-session
#     else
#         tmux new-session -As BASE
#     end
# end
