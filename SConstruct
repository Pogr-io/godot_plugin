#!python

env = SConscript("src/lib/godot-cpp/SConstruct")

if env["platform"] == "macos":
    libexportfolder = "/macos/"

elif env["platform"] in ("linuxbsd", "linux"):
    libexportfolder = "/linux/"

elif env["platform"] == "windows":
    libexportfolder = "/windows/"

if env["target"] == "template_debug":
    debugsuffix = "_debug"
else:
    debugsuffix = ""

env.Append(CPPPATH=["src/"])
sources = Glob("src/*.cpp")

library = env.SharedLibrary(
    target="project/addons/pogr_plugin/bin/"
    + libexportfolder
    + "pogr_sdk"
    + debugsuffix,
    source=sources,
)

Default(library)
