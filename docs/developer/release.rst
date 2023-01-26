Creating a Release
==================

This section aims to help you do a SpyDrNet-TMR release, meaning you make the latest code and documentation available. The steps are listed in what seems to be the best order of operation. Steps which need more explanation are highlighted below.

1. Merge each contributors' branches into one branch (the 'next_release' branch)
2. Run `git merge main` while the next_release branch is checked out.
3. :ref:`update_release_notes` and git commit release notes
4. :ref:`update_documentation` and ensure it can build properly 
5. On Github, create a pull request with the updated code in the next_release branch.
6. Accept and merge the pull request when the checks have finished.
7. Move to the main branch using `git checkout main`
8. :ref:`update_tag`
9. :ref:`build_package` (this will update the documentation’s version number)
10. :ref:`build_documentation`
11. :ref:`github_release`
12. :ref:`publish_documentation`

.. _update_release_notes:

Update the Release Notes
-------------------------

The release notes file called RELEASE.rst should be updated to outline what changes/fixes are in the new release. The date, version number, and other information should all be included.

SpyDrNet-TMR uses a Major.Minor.Bug versioning scheme where minor version updates do not break the existing API and major version updates may break it. Bug fixes do not add substantial new functionality, but rather fix broken functionality.

.. _update_documentation:

Update the Documentation
--------------------------

Sphinx pulls from doc strings as well as .rst files to build documentation. The documentation is built using a makefile in the docs folder.

Before building the documentation run `make clean` to clear away the old files.

**Before proceeding, ensure that both of the following are successful** (make sure they execute without errors. Try to minimize the warnings as well):

>>> make html

and

>>> make latexpdf

If you are missing packages run:

>>> make install

You may also need to run `sudo apt install latexmk` and `apt install texlive-latex-extra` to be able to create the pdf file.

The generated files can be found in the build folder. Take a look at them and make sure everything looks good. Later, these commands will be run again, and the html files put online and pdf files added to the Github release files.

.. _update_tag:

Update the tag
--------------

Be sure you are on the main branch.

Tags are used to label the release. When all changes are merged into the main branch, create a new tag.
In the examples below, replace 1.0.0 with the version number you are releasing.

**To see the current version number**

>>> git describe

**Creation**

>>> git tag -a v1.0.0 -m "SpyDrNet-TMR 1.0.0"

**Push your changes to the tags**

>>> git push --tags

A tag may need to be updated if a new commit is pushed to the branch (because the tag will be left on the previous commit) or if you simply mess up. Do the following to force update the tag.

**Updating**

>>> git tag -a v1.0.0 -m "SpyDrNet-TMR 1.0.0" -f

>>> git push --tags -f

.. _build_package:

Build the Python Package
---------------------------

Upgrade pip if needed.

>>> python3 -m pip install --upgrade pip

Make sure everything is up to date

>>> python3 -m pip install --user --upgrade setuptools wheel

Make the python archive package:

>>> python3 setup.py sdist bdist_wheel

The build files will be stored in the following directories 

spydrnet-tmr/build and spydrnet-tmr/dist

.. _build_documentation:

Build the Documentation
--------------------------

Make sure you are in the docs directory

>>> cd docs

then run the followings to build the documentation:

>>> make clean
>>> make latexpdf
>>> make html

Make sure that each one executes and doesn't have errors. Try to minimize the warnings as well.

.. _github_release:

Create a Github Release
-------------------------

Releases can be created on Github. On the releases tab, draft a new release. Select the new tag you just created (it should have the release number).

The release should be named `SpyDrNet-TMR 1.0.0` where 1.0.0 is replaced with the
proper release number.

Enter a description--it could just be a reiteration of the release notes or other relevant information.

Three files need to be added as assets to the new release:
    The two files that were generated during :ref:`build_package` (a tar.gz file and a .whl file).

    The Reference PDF - download the `spydrnet_tmr_reference.pdf` found in the docs/latex folder. Rename it to `spydrnet_tmr_reference-new_release_number.pdf`. If the pdf file doesn't exist, run `make latexpdf` in the /docs folder again.

.. _publish_documentation:

Publishing the documentation
----------------------------

This is easiest on Linux (or at least not Windows, MacOS works fine as well)

Make sure you are still on the main branch and that everything in the html folder is up-to-date.
If not, re-run the instructions in :ref:`build_documentation`.

Checkout the gh-pages branch create a new folder with the release number as the
name. Move the `docs/build/html` folder into the newly created folder. 
Make sure to delete the html folder after you are finished.

(If html folder doesn't contain the latest pages, it could be that the html folder wasn't deleted from the previous release,
delete the folder, commit the changes and repeat the steps above)

The documentation is built from the stable link so the stable link will need to
be updated to point to the newly updated documentation.

Check which version of the documentation the stable link points to

>>> ls -lha

to update the stable link, remove it first (watch syntax here very carefully, a
terminating \ could make the command delete the folder's contents instead of the
link)

>>> rm stable

then create a link to the new folder

>>> ln -s version.number stable

run git add to add the newly created folder and the stable link

push your changes to the git repository, just to the ghpages branch.

The new documentation should show up online now.
