& 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\Launch-VsDevShell.ps1' -Arch amd64

Set-PSDebug -Trace 1

$logdir = "~\issue-7444-logs\";

systeminfo > $logdir\01_systeminfo_out.txt

git clean -dfx
git rev-parse HEAD
git status --ignored

which python
python --version
python .\scripts\install_deps.py 2>&1 | 
  Out-File $logdir\02_win_deps_output.log

cmake -B build --preset=windows-release 2>&1 | 
  Out-File $logdir\03_win_config.log

cmake --build build -j8 2>&1 |
  Out-File $logdir\04_win_build.log
