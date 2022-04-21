-------------------------------------------------------
--Where to put my sessions
vim.g.startify_session_dir = os.getenv("HOME") .. '/.local/share/nvim/sessions'
-------------------------------------------------------

-------------------------------------------------------
--Delete buffers
vim.g.startify_session_delete_buffers = true
-------------------------------------------------------

-------------------------------------------------------
--List
vim.cmd(
[[
let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
]])
-------------------------------------------------------


-------------------------------------------------------
--Bookmarks
vim.cmd(
[[
let g:startify_bookmarks = [
            \ { 'a': '~/.config/nvim/init.lua' },
            \ ]
]])
-------------------------------------------------------


-------------------------------------------------------
--auto load sessions
vim.g.startify_session_autoload = true
-------------------------------------------------------


-------------------------------------------------------
--Take care of buffers
vim.g.startify_session_delete_buffers = true
-------------------------------------------------------


-------------------------------------------------------
--Similar to Vim-rooter
vim.g.startify_change_to_vcs_root = true
-------------------------------------------------------

-------------------------------------------------------
--If you want Unicode
vim.g.startify_fortune_use_unicode = true
-------------------------------------------------------



-------------------------------------------------------
--Automatically Update sessions
vim.g.startify_session_persistence = true
-------------------------------------------------------

-------------------------------------------------------
--Get rid of empy buffer and quit
vim.g.startify_enable_special = true
-------------------------------------------------------


-------------------------------------------------------
--custom header
vim.cmd(
[[
let g:startify_custom_header = [
      \'         o                                              o            o              ',
      \'        <|>                                            <|>         _<|>_            ',
      \'        / \                                            / >                          ',
      \'      o/   \o        o__ __o/     o__ __o/      __o__  \o__ __o      o    \o__ __o  ',
      \'     <|__ __|>      /v     |     /v     |      />  \    |     v\    <|>    |     |> ',
      \'     /       \     />     / \   />     / \     \o      / \     <\   / \   / \   < > ',
      \'   o/         \o   \      \o/   \      \o/      v\     \o/     o/   \o/   \o/       ',
      \'  /v           v\   o      |     o      |        <\     |     <|     |     |        ',
      \' />             <\  <\__  < >    <\__  / \  _\o__</    / \    / \   / \   / \       ',
      \'                           |                                                        ',
      \'                           o                                                        ',
      \'                           <\__                                                     ',
      \]
]])
-------------------------------------------------------