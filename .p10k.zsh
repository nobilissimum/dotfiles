# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
    emulate -L zsh -o extended_glob
    unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

    [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
        # =========================[ Line #1 ]=========================
        dir
        vcs
        # =========================[ Line #2 ]=========================
        newline
        prompt_char
    )

    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        # =========================[ Line #1 ]=========================
        # =========================[ Line #2 ]=========================
        newline
    )

    # Defines character set used by powerlevel10k. It's best to let `p10k configure` set it for you.
    typeset -g POWERLEVEL9K_MODE=nerdfont-complete
    typeset -g POWERLEVEL9K_ICON_PADDING=none
    typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
    typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
    typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
    typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=
    typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
    typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
    if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
        typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=242
        typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
        typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
    fi

    typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
    typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""
    typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
    typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
    typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=""
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""  # 
    typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""  # 
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=""  # 
    typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=""

    #################################[ os_icon: os identifier ]##################################
    typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
    typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=7
    typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='󰻀'

    ################################[ prompt_char: prompt symbol ]################################
    # Transparent background.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="#FFFFFF"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="#FFFFFF"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION=' '
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION=' '
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

    ##################################[ dir: current directory ]##################################
    # Current directory background color.
    typeset -g POWERLEVEL9K_DIR_BACKGROUND="#202733"
    typeset -g POWERLEVEL9K_DIR_FOREGROUND=7
    typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
    typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
    typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=7
    typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=7
    typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

    # Don't shorten directories that contain any of these files. They are anchors.
    local anchor_files=(
        .git
    )
    typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
    typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
    typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
    typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
    typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
    typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
    typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
    typeset -g POWERLEVEL9K_DIR_CLASSES=()

    # Custom prefix.
    # typeset -g POWERLEVEL9K_DIR_PREFIX='in '

    #####################################[ vcs: git status ]######################################
    # Version control background colors.
    typeset -g POWERLEVEL9K_VCS_BEHIND_FOREGROUND=7
    typeset -g POWERLEVEL9K_VCS_BEHIND_BACKGROUND=4

    typeset -g POWERLEVEL9K_VCS_AHEAD_FOREGROUND=7
    typeset -g POWERLEVEL9K_VCS_AHEAD_BACKGROUND=4

    typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=7
    typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2

    typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=0
    typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3

    typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=0
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=3

    typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=5
    typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=5

    typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=8
    typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8

    # Branch icon. Set this parameter to '\UE0A0 ' for the popular Powerline branch icon.
    typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '

    # Untracked files icon. It's really a question mark, your font isn't broken.
    # Change the value of this parameter to show a different icon.
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=''

    # Formatter for Git status.
    #
    # Example output: master wip ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
    #
    # You can edit the function to customize how Git status looks.
    #
    # VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
    # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
    function my_git_formatter() {
        emulate -L zsh

        if [[ -n $P9K_CONTENT ]]; then
        # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
        # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
        typeset -g my_git_format=$P9K_CONTENT
        return
        fi

        # Styling for different parts of Git status.
        # local       meta='%7F' # white foreground
        # local      clean='%0F' # black foreground
        # local   modified='%0F' # black foreground
        # local  untracked='%0F' # black foreground
        # local conflicted='%1F' # red foreground

        local res

        if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
        # If local branch name is at most 32 characters long, show it in full.
        # Otherwise show the first 12 … the last 12.
        # Tip: To always show local branch name in full without truncation, delete the next line.
        (( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line
        res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
        fi

        if [[ -n $VCS_STATUS_TAG
            # Show tag only if not on a branch.
            # Tip: To always show tag, delete the next line.
            && -z $VCS_STATUS_LOCAL_BRANCH  # <-- this line
            ]]; then
        local tag=${(V)VCS_STATUS_TAG}
        # If tag name is at most 32 characters long, show it in full.
        # Otherwise show the first 12 … the last 12.
        # Tip: To always show tag name in full without truncation, delete the next line.
        (( $#tag > 32 )) && tag[13,-13]="…"  # <-- this line
        res+="${meta}#${clean}${tag//\%/%%}"
        fi

        # Display the current Git commit if there is no branch and no tag.
        # Tip: To always display the current Git commit, delete the next line.
        [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&  # <-- this line
        res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

        # Show tracking branch name if it differs from local branch.
        if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
        res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
        fi

        # Display "wip" if the latest commit's summary contains "wip" or "WIP".
        if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
        res+=" ${modified}wip"
        fi

        # ⇣42 if behind the remote.
        # (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
        (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean} ${VCS_STATUS_COMMITS_BEHIND}"

        # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
        # (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
        # (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
        (( VCS_STATUS_COMMITS_AHEAD  )) && res+=" ${clean} ${VCS_STATUS_COMMITS_AHEAD}"

        # ⇠42 if behind the push remote.
        (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean} ${VCS_STATUS_PUSH_COMMITS_BEHIND}"
        (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "

        # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
        (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+=" ${clean} ${VCS_STATUS_PUSH_COMMITS_AHEAD}"

        # *42 if have stashes.
        (( VCS_STATUS_STASHES        )) && res+=" ${clean}󰆓 ${VCS_STATUS_STASHES}"

        # 'merge' if the repo is in an unusual state.
        [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"

        # ~42 if have merge conflicts.
        (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted} ${VCS_STATUS_NUM_CONFLICTED}"

        # +42 if have staged changes.
        # (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
        (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}󰏫 ${VCS_STATUS_NUM_STAGED}"

        # !42 if have unstaged changes.
        # (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
        (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified} ${VCS_STATUS_NUM_UNSTAGED}"

        # ?42 if have untracked files. It's really a question mark, your font isn't broken.
        # See POWERLEVEL9K_VCS_UNTRACKED_ICON above if you want to use a different icon.
        # Remove the next line if you don't want to see untracked files at all.
        (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"

        # "─" if the number of unstaged files is unknown. This can happen due to
        # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a non-negative number lower
        # than the number of files in the Git index, or due to bash.showDirtyState being set to false
        # in the repository config. The number of staged and untracked files may also be unknown
        # in this case.
        (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

        typeset -g my_git_format=$res
    }
    functions -M my_git_formatter 2>/dev/null

    # Don't count the number of unstaged, untracked and conflicted files in Git repositories with
    # more than this many files in the index. Negative value means infinity.
    #
    # If you are working in Git repositories with tens of millions of files and seeing performance
    # sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY to a number lower than the output
    # of `git ls-files | wc -l`. Alternatively, add `bash.showDirtyState = false` to the repository's
    # config: `git config bash.showDirtyState false`.
    typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

    # Don't show Git status in prompt for repositories whose workdir matches this pattern.
    # For example, if set to '~', the Git repository at $HOME/.git will be ignored.
    # Multiple patterns can be combined with '|': '~(|/foo)|/bar/baz/*'.
    # typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

    # Disable the default Git status formatting.
    typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
    # Install our own Git status formatter.
    typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
    # Enable counters for staged, unstaged, etc.
    typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

    # Custom icon.
    typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=
    # Custom prefix.
    # typeset -g POWERLEVEL9K_VCS_PREFIX='on '

    # Show status of repositories of these types. You can add svn and/or hg if you are
    # using them. If you do, your prompt may become slow even when your current directory
    # isn't in an svn or hg repository.
    typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

    ##########################[ status: exit code of the last command ]###########################
    # Enable OK_PIPE, ERROR_PIPE and ERROR_SIGNAL status states to allow us to enable, disable and
    # style them independently from the regular OK and ERROR state.
    typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true

    # Status on success. No content, just an icon. No need to show it if prompt_char is enabled as
    # it will signify success by turning green.
    typeset -g POWERLEVEL9K_STATUS_OK=false
    typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
    typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=254
    typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0

    # Status when some part of a pipe command fails but the overall exit status is zero. It may look
    # like this: 1|0.
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=254
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0

    # Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as
    # it will signify error by turning red.
    typeset -g POWERLEVEL9K_STATUS_ERROR=false
    typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
    typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=254
    typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1

    # Status when the last command was terminated by a signal.
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
    # Use terse signal names: "INT" instead of "SIGINT(2)".
    typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=254
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=1

    # Status when some part of a pipe command fails and the overall exit status is also non-zero.
    # It may look like this: 1|0.
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=254
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1

    ###################[ command_execution_time: duration of the last command ]###################
    # Execution time color.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3
    # Show duration of the last command if takes at least this many seconds.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
    # Show this many fractional digits. Zero means round to seconds.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
    # Duration format: 1d 2h 3m 4s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
    # Custom icon.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
    # Custom prefix.
    # typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='took '

    #######################[ background_jobs: presence of background jobs ]#######################
    # Background jobs color.
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
    # Don't show the number of background jobs.
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
    # Custom icon.
    # typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⭐'

    #######################[ direnv: direnv status (https://direnv.net/) ]########################
    # Direnv color.
    typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=3
    typeset -g POWERLEVEL9K_DIRENV_BACKGROUND=0
    # Custom icon.
    # typeset -g POWERLEVEL9K_DIRENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ###############[ asdf: asdf version manager (https://github.com/asdf-vm/asdf) ]###############
    # Default asdf color. Only used to display tools for which there is no color override (see below).
    # Tip:  Override these parameters for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_FOREGROUND and
    # POWERLEVEL9K_ASDF_${TOOL}_BACKGROUND.
    typeset -g POWERLEVEL9K_ASDF_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_BACKGROUND=7

    # There are four parameters that can be used to hide asdf tools. Each parameter describes
    # conditions under which a tool gets hidden. Parameters can hide tools but not unhide them. If at
    # least one parameter decides to hide a tool, that tool gets hidden. If no parameter decides to
    # hide a tool, it gets shown.
    #
    # Special note on the difference between POWERLEVEL9K_ASDF_SOURCES and
    # POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW. Consider the effect of the following commands:
    #
    #   asdf local  python 3.8.1
    #   asdf global python 3.8.1
    #
    # After running both commands the current python version is 3.8.1 and its source is "local" as
    # it takes precedence over "global". If POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW is set to false,
    # it'll hide python version in this case because 3.8.1 is the same as the global version.
    # POWERLEVEL9K_ASDF_SOURCES will hide python version only if the value of this parameter doesn't
    # contain "local".

    # Hide tool versions that don't come from one of these sources.
    #
    # Available sources:
    #
    # - shell   `asdf current` says "set by ASDF_${TOOL}_VERSION environment variable"
    # - local   `asdf current` says "set by /some/not/home/directory/file"
    # - global  `asdf current` says "set by /home/username/file"
    #
    # Note: If this parameter is set to (shell local global), it won't hide tools.
    # Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SOURCES.
    typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)

    # If set to false, hide tool versions that are the same as global.
    #
    # Note: The name of this parameter doesn't reflect its meaning at all.
    # Note: If this parameter is set to true, it won't hide tools.
    # Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_PROMPT_ALWAYS_SHOW.
    typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false

    # If set to false, hide tool versions that are equal to "system".
    #
    # Note: If this parameter is set to true, it won't hide tools.
    # Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_SYSTEM.
    typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true

    # If set to non-empty value, hide tools unless there is a file matching the specified file pattern
    # in the current directory, or its parent directory, or its grandparent directory, and so on.
    #
    # Note: If this parameter is set to empty value, it won't hide tools.
    # Note: SHOW_ON_UPGLOB isn't specific to asdf. It works with all prompt segments.
    # Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_ON_UPGLOB.
    #
    # Example: Hide nodejs version when there is no package.json and no *.js files in the current
    # directory, in `..`, in `../..` and so on.
    #
    #   typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.js|package.json'
    typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=

    # Ruby version from asdf.
    typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_RUBY_BACKGROUND=1
    # typeset -g POWERLEVEL9K_ASDF_RUBY_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_RUBY_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Python version from asdf.
    typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_PYTHON_BACKGROUND=4
    # typeset -g POWERLEVEL9K_ASDF_PYTHON_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_PYTHON_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Go version from asdf.
    typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_GOLANG_BACKGROUND=4
    # typeset -g POWERLEVEL9K_ASDF_GOLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_GOLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Node.js version from asdf.
    typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_NODEJS_BACKGROUND=2
    # typeset -g POWERLEVEL9K_ASDF_NODEJS_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Rust version from asdf.
    typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_RUST_BACKGROUND=208
    # typeset -g POWERLEVEL9K_ASDF_RUST_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_RUST_SHOW_ON_UPGLOB='*.foo|*.bar'

    # .NET Core version from asdf.
    typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_BACKGROUND=5
    # typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Flutter version from asdf.
    typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_FLUTTER_BACKGROUND=4
    # typeset -g POWERLEVEL9K_ASDF_FLUTTER_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_FLUTTER_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Lua version from asdf.
    typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_LUA_BACKGROUND=4
    # typeset -g POWERLEVEL9K_ASDF_LUA_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_LUA_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Java version from asdf.
    typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=1
    typeset -g POWERLEVEL9K_ASDF_JAVA_BACKGROUND=7
    # typeset -g POWERLEVEL9K_ASDF_JAVA_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_JAVA_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Perl version from asdf.
    typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_PERL_BACKGROUND=4
    # typeset -g POWERLEVEL9K_ASDF_PERL_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_PERL_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Erlang version from asdf.
    typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_ERLANG_BACKGROUND=1
    # typeset -g POWERLEVEL9K_ASDF_ERLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_ERLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Elixir version from asdf.
    typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_ELIXIR_BACKGROUND=5
    # typeset -g POWERLEVEL9K_ASDF_ELIXIR_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_ELIXIR_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Postgres version from asdf.
    typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_POSTGRES_BACKGROUND=6
    # typeset -g POWERLEVEL9K_ASDF_POSTGRES_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_POSTGRES_SHOW_ON_UPGLOB='*.foo|*.bar'

    # PHP version from asdf.
    typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_PHP_BACKGROUND=5
    # typeset -g POWERLEVEL9K_ASDF_PHP_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_PHP_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Haskell version from asdf.
    typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_HASKELL_BACKGROUND=3
    # typeset -g POWERLEVEL9K_ASDF_HASKELL_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_HASKELL_SHOW_ON_UPGLOB='*.foo|*.bar'

    # Julia version from asdf.
    typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND=0
    typeset -g POWERLEVEL9K_ASDF_JULIA_BACKGROUND=2
    # typeset -g POWERLEVEL9K_ASDF_JULIA_VISUAL_IDENTIFIER_EXPANSION='⭐'
    # typeset -g POWERLEVEL9K_ASDF_JULIA_SHOW_ON_UPGLOB='*.foo|*.bar'

    ##########[ nordvpn: nordvpn connection status, linux only (https://nordvpn.com/) ]###########
    # NordVPN connection indicator color.
    typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=7
    typeset -g POWERLEVEL9K_NORDVPN_BACKGROUND=4
    # Hide NordVPN connection indicator when not connected.
    typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
    typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=
    # Custom icon.
    # typeset -g POWERLEVEL9K_NORDVPN_VISUAL_IDENTIFIER_EXPANSION='⭐'

    #################[ ranger: ranger shell (https://github.com/ranger/ranger) ]##################
    # Ranger shell color.
    typeset -g POWERLEVEL9K_RANGER_FOREGROUND=3
    typeset -g POWERLEVEL9K_RANGER_BACKGROUND=0
    # Custom icon.
    # typeset -g POWERLEVEL9K_RANGER_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ######################[ nnn: nnn shell (https://github.com/jarun/nnn) ]#######################
    # Nnn shell color.
    typeset -g POWERLEVEL9K_NNN_FOREGROUND=0
    typeset -g POWERLEVEL9K_NNN_BACKGROUND=6
    # Custom icon.
    # typeset -g POWERLEVEL9K_NNN_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ######################[ lf: lf shell (https://github.com/gokcehan/lf) ]#######################
    # lf shell color.
    typeset -g POWERLEVEL9K_LF_FOREGROUND=0
    typeset -g POWERLEVEL9K_LF_BACKGROUND=6
    # Custom icon.
    # typeset -g POWERLEVEL9K_LF_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ##################[ xplr: xplr shell (https://github.com/sayanarijit/xplr) ]##################
    # xplr shell color.
    typeset -g POWERLEVEL9K_XPLR_FOREGROUND=0
    typeset -g POWERLEVEL9K_XPLR_BACKGROUND=6
    # Custom icon.
    # typeset -g POWERLEVEL9K_XPLR_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ###########################[ vim_shell: vim shell indicator (:sh) ]###########################
    # Vim shell indicator color.
    typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=0
    typeset -g POWERLEVEL9K_VIM_SHELL_BACKGROUND=2
    # Custom icon.
    # typeset -g POWERLEVEL9K_VIM_SHELL_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ######[ midnight_commander: midnight commander shell (https://midnight-commander.org/) ]######
    # Midnight Commander shell color.
    typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=3
    typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_BACKGROUND=0
    # Custom icon.
    # typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_VISUAL_IDENTIFIER_EXPANSION='⭐'

    #[ nix_shell: nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html) ]##
    # Nix shell color.
    typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=0
    typeset -g POWERLEVEL9K_NIX_SHELL_BACKGROUND=4

    # Tip: If you want to see just the icon without "pure" and "impure", uncomment the next line.
    # typeset -g POWERLEVEL9K_NIX_SHELL_CONTENT_EXPANSION=

    # Custom icon.
    # typeset -g POWERLEVEL9K_NIX_SHELL_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ###########[ vi_mode: vi mode (you don't need this if you've enabled prompt_char) ]###########
    # Foreground color.
    typeset -g POWERLEVEL9K_VI_MODE_FOREGROUND=0
    # Text and color for normal (a.k.a. command) vi mode.
    typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
    typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=2
    # Text and color for visual vi mode.
    typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
    typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=4
    # Text and color for overtype (a.k.a. overwrite and replace) vi mode.
    typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
    typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3
    # Text and color for insert vi mode.
    typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
    typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=8

    #####################################[ swap: used swap ]######################################
    # Swap color.
    typeset -g POWERLEVEL9K_SWAP_FOREGROUND=0
    typeset -g POWERLEVEL9K_SWAP_BACKGROUND=3
    # Custom icon.
    # typeset -g POWERLEVEL9K_SWAP_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ######################################[ load: CPU load ]######################################
    # Show average CPU load over this many last minutes. Valid values are 1, 5 and 15.
    typeset -g POWERLEVEL9K_LOAD_WHICH=5
    # Load color when load is under 50%.
    typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=0
    typeset -g POWERLEVEL9K_LOAD_NORMAL_BACKGROUND=2
    # Load color when load is between 50% and 70%.
    typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=0
    typeset -g POWERLEVEL9K_LOAD_WARNING_BACKGROUND=3
    # Load color when load is over 70%.
    typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=0
    typeset -g POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND=1
    # Custom icon.
    # typeset -g POWERLEVEL9K_LOAD_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ###########[ timewarrior: timewarrior tracking status (https://timewarrior.net/) ]############
    # Timewarrior color.
    typeset -g POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=255
    typeset -g POWERLEVEL9K_TIMEWARRIOR_BACKGROUND=8

    # If the tracked task is longer than 24 characters, truncate and append "…".
    # Tip: To always display tasks without truncation, delete the following parameter.
    # Tip: To hide task names and display just the icon when time tracking is enabled, set the
    # value of the following parameter to "".
    typeset -g POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'

    # Custom icon.
    # typeset -g POWERLEVEL9K_TIMEWARRIOR_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ##############[ taskwarrior: taskwarrior task count (https://taskwarrior.org/) ]##############
    # Taskwarrior color.
    typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND=0
    typeset -g POWERLEVEL9K_TASKWARRIOR_BACKGROUND=6

    # Taskwarrior segment format. The following parameters are available within the expansion.
    #
    # - P9K_TASKWARRIOR_PENDING_COUNT   The number of pending tasks: `task +PENDING count`.
    # - P9K_TASKWARRIOR_OVERDUE_COUNT   The number of overdue tasks: `task +OVERDUE count`.
    #
    # Zero values are represented as empty parameters.
    #
    # The default format:
    #
    #   '${P9K_TASKWARRIOR_OVERDUE_COUNT:+"!$P9K_TASKWARRIOR_OVERDUE_COUNT/"}$P9K_TASKWARRIOR_PENDING_COUNT'
    #
    # typeset -g POWERLEVEL9K_TASKWARRIOR_CONTENT_EXPANSION='$P9K_TASKWARRIOR_PENDING_COUNT'

    # Custom icon.
    # typeset -g POWERLEVEL9K_TASKWARRIOR_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ################################[ cpu_arch: CPU architecture ]################################
    # CPU architecture color.
    typeset -g POWERLEVEL9K_CPU_ARCH_FOREGROUND=0
    typeset -g POWERLEVEL9K_CPU_ARCH_BACKGROUND=3

    # Hide the segment when on a specific CPU architecture.
    # typeset -g POWERLEVEL9K_CPU_ARCH_X86_64_CONTENT_EXPANSION=
    # typeset -g POWERLEVEL9K_CPU_ARCH_X86_64_VISUAL_IDENTIFIER_EXPANSION=

    # Custom icon.
    # typeset -g POWERLEVEL9K_CPU_ARCH_VISUAL_IDENTIFIER_EXPANSION='⭐'

    ##################################[ context: user@hostname ]##################################
    # Context color when running with privileges.
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0
    typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=3
    typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_BACKGROUND=0
    typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=3
    typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0

    typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%n@%m'
    typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
    typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'

    typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

    typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=0
    typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=4
    typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
    typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
    typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

    ##############################################################################################

    function prompt_example() {
        p10k segment -b 1 -f 3 -i '⭐' -t 'hello, %n'
    }

    function instant_prompt_example() {
        # Since prompt_example always makes the same `p10k segment` calls, we can call it from
        # instant_prompt_example. This will give us the same `example` prompt segment in the instant
        # and regular prompts.
        prompt_example
    }

    # User-defined prompt segments can be customized the same way as built-in segments.
    typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=3
    typeset -g POWERLEVEL9K_EXAMPLE_BACKGROUND=1
    # typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'

    # Transient prompt
    typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

    # Instant prompt mode
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

    # Hot reload
    typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=false

    # If p10k is already loaded, reload configuration.
    # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
    (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
