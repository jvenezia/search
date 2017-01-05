workers ENV.fetch('PUMA_WORKERS') { 5 }.to_i
thread_count = ENV.fetch('PUMA_WORKER_THREADS') { 5 }.to_i
threads thread_count, thread_count

preload_app!

port ENV.fetch('PORT') { 3000 }
environment ENV.fetch('RAILS_ENV') { 'development' }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart