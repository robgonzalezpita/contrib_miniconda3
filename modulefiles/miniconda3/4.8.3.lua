help([[
]])

local pkgName = myModuleName()
local pkgVersion = myModuleVersion()
local shell=myShellType()

conflict(pkgName)

local base=pathJoin("/lustre/f2/pdata/esrl/gsd/contrib/miniconda3", pkgVersion)
local home=os.getenv("HOME")
local conda_file=pathJoin(base,"etc", "profile.d", "conda." .. shell)
local command="source " .. conda_file

if mode() == "load" then
  execute{cmd=command, modeA={"load"}}
elseif mode() == "unload" then
  if shell == "csh" then
    execute{cmd="unalias conda", modeA={"unload"}}
  end
  remove_path("PATH", pathJoin(base, "condabin"))
  remove_path("MANPATH", pathJoin(base, "share", "man"))
end

prepend_path("PATH",            pathJoin(base, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib"))
prepend_path("CONDA_ENVS_PATH", pathJoin(home, ".conda", "envs"))
prepend_path("CONDA_PKGS_PATH", pathJoin(home, ".conda", "pkgs"))
