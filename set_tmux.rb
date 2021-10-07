require 'json'

def send_tmux_command(ref, cmd)
 system("tmux send-keys -t #{ref} \"#{cmd}\" ENTER")
end

file = File.read('./tmux.dev.conf.json')

conf_tmux = JSON.parse(file)

sessions = conf_tmux['sessions']

sessions.each_with_index do |session, session_index|
  system("tmux new-session -d -s #{session['name']}")
  
  windows = session['windows']

  windows.each_with_index do |window, window_index| 
    ref = "#{session['name']}:#{window_index + 1}"

    system("tmux new-window -t #{ref} -n #{window['name']}")
    send_tmux_command ref, "cd #{window['path']}"
    send_tmux_command ref, "clear"
    
    system("tmux split-window -h")
    send_tmux_command "#{ref}.1", "cd #{window['path']}"
    send_tmux_command "#{ref}.1", "clear"
  end
end

system("tmux a")
