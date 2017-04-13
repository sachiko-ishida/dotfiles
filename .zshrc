source ~/.zplug/init.zsh

# エイリアス設定
alias mv="mv -i"
alias rm="rm -i"

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ヒストリを共有
setopt share_history
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

# プロンプトの設定
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt PROMPT_SUBST
# 補完
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## '='以降の入力も補完する
setopt magic_equal_subst
## 補完関数の設定
## 補完候補をカーソルで選択可能にする
zstyle ':completion:*:default' menu select=1
## 補完候補をグルーピングして表示する
zstyle ':completion:*' completer _expand _complete _match _approximate _history
    # _expand: グロブや変数を展開する
    # _complete: 通常の補完
    # _match: グロブでコマンドを補完する
    # _approximate: ミススペルを訂正して補完する
    # _history: 履歴から補完する
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
## 自動入力されるカンマなどを適宜削除する
setopt auto_param_keys
## 補完候補を詰めて表示
setopt list_packed
# others
## ビープを鳴らさない
setopt nobeep
## ディレクトリ名だけで cd
setopt auto_cd
## cdの履歴を保存
setopt auto_pushd
## 重複したcdの履歴は保存しない
setopt pushd_ignore_dups
## 3秒以上の処理は自動的に処理時間を表示
REPORTTIME=3

# pecoで履歴を検索する
function peco-history-selection() {
    cmd='tac'
    case "${OSTYPE}" in
        freebsd*|darwin*)
            cmd=('tail' '-r')
        ;;
    esac
    BUFFER=`history -n 1 | $cmd | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection

# pecoでスニペットを読み込む
function peco-snippets-loader() {
    if ls ~/.peco.snippet* >/dev/null 2>&1; then
        snippet=`cat ~/.peco.snippet* | grep -v "^#" | peco`
        BUFFER="$(echo $snippet | sed -e 's/^\[.*\] *//') "
        CURSOR=$#BUFFER
    else
        echo "~/.peco.snippet* is not found."
    fi
    zle reset-prompt
}
zle -N peco-snippets-loader

# peco関係の関数をキーバインドに登録
if type peco >/dev/null 2>&1; then
    bindkey '^r' peco-history-selection
    bindkey '^x' peco-snippets-loader
fi
# zplug plugins
zplug 'mafredri/zsh-async', on:sindresorhus/pure
zplug 'sindresorhus/pure', use:pure.zsh, as:theme
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

