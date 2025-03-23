NVIM v0.11.0-dev-636+ga8fbe1d40
Build type: RelWithDebInfo
LuaJIT 2.1.1724081603
Run "nvim -V1 -v" for more info

ripgrep 14.1.0

features:-simd-accel,+pcre2
simd(compile):+NEON
simd(runtime):+NEON

LAZYGIT

commit=, build date=, build source=homebrew, version=0.43.1, os=darwin, arch=arm64, git version=2.46.0

For [NVR](https://github.com/mhinz/neovim-remote) usage:

Add the following to .zshrc or .bashrc:  

```
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
    export GIT_EDITOR=nvim
fi
```

And this to lazgit/config.yml:  

```
os:
  # this will edit the file in the current neovim sesh
  edit: "nvr -cc vsplit --remote-wait +'set bufhidden=wipe' {{filename}}"
```
