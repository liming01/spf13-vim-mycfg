# Path to your oh-my-zsh installation.
export ZSH=/Users/gpadmin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ulimit -u 1024
ulimit -c unlimited
ulimit -n 8192

export PATH=".:$PATH"
alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias lvim="vim -u ~/.vimrc.complex"
alias lnvim="nvim -u ~/.vimrc.complex"
alias pp="ps -ef | grep postgres | grep -v grep"
alias pj="ps -ef | grep java | grep -v grep"

########### env setting for HAWQ ##############
#[ -f ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh ] && source ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh
#export PATH=/Users/gpadmin/workspace/postgresql/install/cdb/bin:$PATH
#export PATH=/Users/gpadmin/workspace/postgresql/install/postgres-xl/bin:$PATH
#export PATH=/Users/gpadmin/workspace/postgresql/install/postgres/bin:$PATH

#export GPHD_ROOT=/Users/gpadmin/workspace/install/singlecluster-HDP
#export HADOOP_ROOT=$GPHD_ROOT/hadoop
#export HBASE_ROOT=$GPHD_ROOT/hbase
#export HIVE_ROOT=$GPHD_ROOT/hive
#export ZOOKEEPER_ROOT=$GPHD_ROOT/zookeeper
#export PATH=$PATH:$GPHD_ROOT/bin:$HADOOP_ROOT/bin:$HBASE_ROOT/bin:$HIVE_ROOT/bin:$ZOOKEEPER_ROOT/bin

#export PYTHONPATH=/usr/local/Cellar/python/2.7.13/Frameworks/Python.framework/Versions/2.7/lib/python2.7
#export PYTHONHOME=/usr/local/Cellar/python/2.7.13/Frameworks/Python.framework/Versions/2.7
#export PATH=$PYTHONHOME/bin:$PATH
# Add awscli path to $PATH
#export PATH=~/Library/Python/2.7/bin:$PATH

########### End of env setting for HAWQ ##############

########### env setting for gpdb ##############
#[ -f ~/workspace/install/gpdb/greenplum_path.sh ] && source ~/workspace/install/gpdb/greenplum_path.sh
#export MASTER_DATA_DIRECTORY=/Users/gpadmin/workspace/gpdb/gpAux/gpdemo/datadirs/qddir/demoDataDir-1

[ -f ~/workspace/install/gpdb4/greenplum_path.sh ] && source ~/workspace/install/gpdb4/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/Users/gpadmin/workspace/gpdb4/gpAux/gpdemo/datadirs/qddir/demoDataDir-1

########### End of env setting for gpdb ##############
export LC_ALL=en_US.UTF-8
export PGDATESTYLE=postgres,MDY
