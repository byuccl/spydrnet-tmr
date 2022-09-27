import os

# Version information
name = "spydrnet_shrec"
version = "UNSPECIFIED"
release = "UNSPECIFIED"
date = "UNSPECIFIED"

# Declare current release as a development release.
# Change to False before tagging a release; then change back.
dev = False

description = "Python package of netlist analysis and transformation applications for space, high-performance, and resilient computing."
license = "None"
authors = {
    "Keller": ("Andrew Keller", "andrewmkeller@byu.edu"),
    "Skouson": ("Dallin Skouson", "dallinskouson@byu.edu"),
    "Wirthlin": ("Michael Wirthlin", "wirthlin@byu.edu"),
}
maintainer = "SpyDrNet SHREC Developers"
maintainer_email = "spydrnet-shrec-discuss@googlegroups.com"
url = "https://byuccl.github.io/spydrnet"
project_urls = {
    "Bug Tracker": "https://github.com/byuccl/spydrnet-shrec/issues",
    "Source Code": "https://github.com/byuccl/spydrnet-shrec",
}
platforms = ["Linux", "Mac OSX", "Windows", "Unix"]
keywords = [
    "Netlist",
    "Analysis",
    "Transformation",
    "netlist",
    "FPGA",
    "primitives",
    "module",
    "port",
    "EDIF",
    "Digital",
    "Hardware",
]
classifiers = [
    "Development Status :: 1 - Planning",
    "Intended Audience :: Developers",
    "Intended Audience :: Education",
    "Intended Audience :: Science/Research",
    "License :: OSI Approved :: BSD License",
    "Operating System :: OS Independent",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.5",
    "Programming Language :: Python :: 3.6",
    "Programming Language :: Python :: 3.7",
    "Programming Language :: Python :: 3.8",
    "Programming Language :: Python :: 3 :: Only",
    "Topic :: Education",
    "Topic :: Scientific/Engineering",
    "Topic :: Scientific/Engineering :: Information Analysis",
    "Topic :: Scientific/Engineering :: Electronic Design Automation (EDA)",
    "Topic :: Software Development :: Libraries :: Python Modules",
]


directory = os.path.dirname(os.path.abspath(__file__))
version_filename = os.path.join(directory, "VERSION")


def load_versionfile():
    global release
    global version
    global date
    if os.path.isfile(version_filename):
        with open(version_filename) as fi:
            release = fi.readline().strip()[1:]
            second_period_index = _get_second_period_index(release)
            version = release[:second_period_index]
            date = fi.readline().strip()


def _get_second_period_index(string_value):
    period_count = 0
    for index, char in enumerate(string_value):
        if string_value[index] == ".":
            period_count += 1
        if period_count == 2:
            return index
    return len(string_value)


load_versionfile()


def update_versionfile():
    import datetime
    import time
    import subprocess

    global version
    global date

    date_info = datetime.datetime.utcfromtimestamp(
        int(os.environ.get("SOURCE_DATE_EPOCH", time.time()))
    )
    date = time.asctime(date_info.timetuple())

    # check for git on path
    git_exists = False
    for path in os.environ["PATH"].split(os.pathsep):
        exe_file = os.path.join(path, "git")
        if os.path.isfile(exe_file) and os.access(exe_file, os.X_OK):
            git_exists = True
        else:
            exe_file = os.path.join(path, "git.exe")
            if os.path.isfile(exe_file) and os.access(exe_file, os.X_OK):
                git_exists = True

    if git_exists:
        git_subprocess = subprocess.Popen(
            ["git describe"],
            shell=True,
            cwd=directory,
            stdout=subprocess.PIPE,
        )
        git_describe_output = git_subprocess.stdout.read().decode()

        git_version = git_describe_output.strip()
        if git_version.startswith("v"):
            version_file = os.path.join(directory, "VERSION")
            with open(version_file, "w") as fh:
                fh.write(git_version + "\n")
                fh.write(date + "\n")
            version = git_version[1:]

    return version


if __name__ == "__main__":
    update_versionfile()
