
eval PATH="/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/Users/dawn/synergy-core/deps/qt/6.7.2/macos/bin:/Users/dawn/.local/share/mise/installs/usage/latest/bin:/Users/dawn/.local/share/mise/installs/ruby/3.3.1/bin:/Users/dawn/.local/share/mise/installs/node/22.2.0/bin:/Users/dawn/.local/share/mise/installs/go/1.22.4/bin:/Users/dawn/.local/share/mise/installs/go/1.22.4/go/bin:/Users/dawn/.local/share/mise/installs/yarn/1.22.22/bin:/Users/dawn/.local/share/mise/installs/python/3.11.9/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Users/dawn/.cargo/bin:/Applications/iTerm.app/Contents/Resources/utilities:/Users/dawn/.local/bin"; export PATH;
eval export HOMEBREW_PREFIX="/opt/homebrew"; export HOMEBREW_CELLAR="/opt/homebrew/Cellar"; export HOMEBREW_REPOSITORY="/opt/homebrew"; export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"; [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"; export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export logdir="$HOME/issue-7444-logs/2024-08-20-try-2dcf1304"

set -x

system_profiler -detailLevel mini > "$logdir/11_system_profiler_out.txt"

git clean -dfx
git rev-parse HEAD
git status --ignored

which python3
python3 --version
python3 ./scripts/install_deps.py 2>&1 | 
  tee &>/dev/null $logdir/12_mac_deps_output.log

cmake -B build --preset=macos-release 2>&1 | 
  tee &>/dev/null $logdir/13_mac_config.log

cmake --build build -j8 2>&1 |
  tee &>/dev/null $logdir/14_mac_build.log
