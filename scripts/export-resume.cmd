@echo off
setlocal
cd /d "%~dp0.."

where node >nul 2>&1
if errorlevel 1 goto missing_node
where npm.cmd >nul 2>&1
if errorlevel 1 goto missing_node

if exist "node_modules\@marp-team\marp-cli\marp-cli.js" goto resume
call npm.cmd ci
if errorlevel 1 goto failed

:resume
if exist "resume.md" goto export
node scripts/init-resume.mjs zh
if errorlevel 1 goto failed
echo resume.md created from the Chinese template. Edit it, then run this file again.
pause
exit /b 0

:export
node scripts/export-interactive.mjs
if errorlevel 1 goto failed
pause
exit /b 0

:missing_node
echo Node.js 18+ and npm are required. Install from https://nodejs.org/
:failed
echo Export did not complete. See the error above.
pause
exit /b 1
