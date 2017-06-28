[Midnight-Commander]
verbose=1
pause_after_run=1
shell_patterns=1
auto_save_setup=0
preallocate_space=0
auto_menu=0
use_internal_view=1
use_internal_edit=0
clear_before_exec=1
confirm_delete=1
confirm_overwrite=1
confirm_execute=0
confirm_history_cleanup=1
confirm_exit=0
confirm_directory_hotlist_delete=1
safe_delete=0
mouse_repeat_rate=100
double_click_speed=250
use_8th_bit_as_meta=0
confirm_view_dir=0
mouse_move_pages_viewer=1
mouse_close_dialog=0
fast_refresh=0
drop_menus=0
wrap_mode=1
old_esc_mode=1
old_esc_mode_timeout=100000
cd_symlinks=1
show_all_if_ambiguous=0
max_dirt_limit=10
use_file_to_guess_type=1
alternate_plus_minus=0
only_leading_plus_minus=1
show_output_starts_shell=0
xtree_mode=0
num_history_items_recorded=60
file_op_compute_totals=1
classic_progressbar=1
vfs_timeout=60
ftpfs_directory_timeout=900
use_netrc=1
ftpfs_retry_seconds=30
ftpfs_always_use_proxy=0
ftpfs_use_passive_connections=1
ftpfs_use_passive_connections_over_proxy=0
ftpfs_use_unix_list_options=1
ftpfs_first_cd_then_ls=1
fish_directory_timeout=900
editor_tab_spacing=8
editor_word_wrap_line_length=72
editor_fill_tabs_with_spaces=0
editor_return_does_auto_indent=1
editor_backspace_through_tabs=0
editor_fake_half_tabs=1
editor_option_save_mode=0
editor_option_save_position=1
editor_option_auto_para_formatting=0
editor_option_typewriter_wrap=0
editor_edit_confirm_save=1
editor_syntax_highlighting=1
editor_persistent_selections=1
editor_drop_selection_on_copy=1
editor_cursor_beyond_eol=0
editor_cursor_after_inserted_block=0
editor_visible_tabs=1
editor_visible_spaces=1
editor_line_state=0
editor_simple_statusbar=0
editor_check_new_line=0
editor_show_right_margin=0
editor_group_undo=0
editor_state_full_filename=0
editor_ask_filename_before_edit=0
nice_rotating_dash=1
mcview_remember_file_position=0
auto_fill_mkdir_name=1
copymove_persistent_attr=1
editor_backup_extension=~
editor_filesize_threshold=64M
editor_stop_format_chars=-+*\\,.;:&>
mcview_eof=
ignore_ftp_chattr_errors=true
skin=darkfar
filepos_max_saved_entries=1024

[Layout]
message_visible=0
keybar_visible=0
xterm_title=1
output_lines=0
command_prompt=0
menubar_visible=0
free_space=1
horizontal_split=0
vertical_equal=1
left_panel_size=79
horizontal_equal=1
top_panel_size=23

[Misc]
timeformat_recent=%b %e %H:%M
timeformat_old=%b %e  %Y
ftp_proxy_host=gate
ftpfs_password=anonymous@
display_codepage=UTF-8
source_codepage=Other_8_bit
autodetect_codeset=
clipboard_store=
clipboard_paste=

[Colors]
base_color=
linux=
color_terminals=

xterm=

screen=

xterm-256color=

screen-256color=

[Panels]
show_mini_info=true
kilobyte_si=true
mix_all_files=false
show_backups=true
show_dot_files=false
fast_reload=false
fast_reload_msg_shown=false
mark_moves_down=true
reverse_files_only=true
auto_save_setup_panels=false
navigate_with_arrows=true
panel_scroll_pages=true
mouse_move_pages=true
filetype_mode=true
permission_mode=true
torben_fj_mode=false
quick_search_mode=2
select_flags=6

simple_swap=false

panel_scroll_center=false

[HotlistConfig]
expanded_view_of_groups=0

[FindFile]
file_case_sens=true
file_shell_pattern=true
file_find_recurs=true
file_skip_hidden=false
file_all_charsets=false
content_use=true
content_case_sens=true
content_regexp=false
content_first_hit=false
content_whole_words=false
content_all_charsets=false
ignore_dirs_enable=true
ignore_dirs=

[Panelize]
Find *.orig after patching=find . -name \\*.orig -print
Find SUID and SGID programs=find . \\( \\( -perm -04000 -a -perm /011 \\) -o \\( -perm -02000 -a -perm /01 \\) \\) -print
Find rejects after patching=find . -name \\*.rej -print
Modified git files=git ls-files --modified