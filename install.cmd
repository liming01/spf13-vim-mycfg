@echo off
set CURRENT_DIR=%cd%

set FILE_DIR=%~dp0/
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%
@echo on

del "%HOME%\.gvimrc.local"
del "%HOME%\.vimrc.*fork"
del "%HOME%\.vimrc.local"
del "%HOME%\.ycm_extra_conf.py"

call mklink "%HOME%\.gvimrc.local" "%FILE_DIR%\.gvimrc.local"
call mklink "%HOME%\.vimrc.before.fork" "%FILE_DIR%\.vimrc.before.fork"
call mklink "%HOME%\.vimrc.bundles.fork" "%FILE_DIR%\.vimrc.bundles.fork"
call mklink "%HOME%\.vimrc.fork" "%FILE_DIR%\.vimrc.fork"
call mklink "%HOME%\.vimrc.local" "%FILE_DIR%\.vimrc.local"
call mklink "%HOME%\.vimrc.common" "%FILE_DIR%\.vimrc.common"
call mklink "%HOME%\.vimrc.simple" "%FILE_DIR%\.vimrc.simple"
call mklink "%HOME%\.ycm_extra_conf.py" "%FILE_DIR%\.ycm_extra_conf.py"

call mklink "%HOME%\.vimrc" "%FILE_DIR%\.vimrc.simple"
@set APP_PATH=%HOME%\.spf13-vim-3
call mklink /J "%HOME%\.vim.complex" "%APP_PATH%\.vim"

call vim -u "%HOME%/.vimrc.complex" +BundleInstall! +BundleClean +qall

@cd %CURRENT_DIR%
@pause
