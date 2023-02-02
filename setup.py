import sys
import setuptools
import glob
import os

if sys.argv[-1] == "setup.py":
    print("To install, run 'python setup.py install'")
    print()

if sys.version_info[:2] < (3, 6):
    python_version = "{}.{}".format(sys.version_info[0], sys.version_info[1])
    msg = "SpyDrNet TMR 1.2+ requires Python 3.6 or later ({} detected).\n\n".format(
        python_version
    )
    sys.stderr.write(msg + "\n")
    sys.exit(1)

# Write the version information.
sys.path.insert(0, "spydrnet_tmr")
import release
version = release.update_versionfile()
sys.path.pop(0)

with open("README.md", "r") as fh:
    long_description = fh.read().replace(":ref:", "")

support_files = list()
folder_path = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "spydrnet_tmr", "support_files"))
for filename in glob.glob(
    os.path.join(folder_path, "**", "*"), recursive=True):
    if os.path.isfile(filename) and ".py" not in filename:
        support_files.append(
            "support_files/"
            + str(filename)[len(folder_path) + 1 :].replace("\\", "/")
        )

extras_require = {"all": ["pytest"], "pytest": ["pytest"]}

if __name__ == "__main__":

    setuptools.setup(
        name=release.name.lower(),
        version=version,
        maintainer=release.maintainer,
        maintainer_email=release.maintainer_email,
        author=release.authors["Keller"][0],
        author_email=release.authors["Keller"][1],
        description=release.description,
        keywords=release.keywords,
        long_description=long_description,
        license=release.license,
        platforms=release.platforms,
        url=release.url,
        project_urls=release.project_urls,
        classifiers=release.classifiers,
        package_data={"spydrnet_tmr": ["VERSION"] + support_files},
        packages=setuptools.find_packages(),
        extras_require=extras_require,
        install_requires=["spydrnet>=1.4,<2", "pyyaml"],
        python_requires=">=3.6",
        zip_safe=False,
    )
