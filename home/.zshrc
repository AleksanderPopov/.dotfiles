# Enable Powerlevel10k instant prompt. Should stay close to the top of zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
source $HOME/.zsh_env
source $HOME/.zsh_prompt
source $HOME/.zsh_settings
source $HOME/.zsh_langs
source $HOME/.zsh_plugins
source $HOME/.zsh_aliases
source $HOME/.zsh_functions
source $HOME/.zsh_fzf
# zprof
unsetopt share_history

PATH="/Users/alexanderpopov/perl5/bin${PATH:+:${PATH}}"; export PATH;

PERL5LIB="/Users/alexanderpopov/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/alexanderpopov/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/alexanderpopov/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/alexanderpopov/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
