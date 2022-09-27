Creating a Release
==================

This section aims to help you do a SpyDrNet_SHREC release, meaning you make the latest code and documentation available. The steps are listed in what seems to be the best order of operation. Steps which need more explanation are highlighted below.

1. Merge each contributors' branches into one branch (the 'next_release' branch)
2. Run `git merge master` while the next_release branch is checked out.
3. On Github, create a pull request with the updated code in the next_release branch.
4. :ref:`update_release_notes`
5. :ref:`update_documentation` and ensure it can build properly
6. Commit and push those changes to the open pull request. Accept and merge the pull request when the checks have finished.
7. Move to the master branch using `git checkout master`
8. :ref:`update_tag`
9. :ref:`build_package` (this will update the documentation’s version number)
10. :ref:`build_documentation`
11. :ref:`github_release`
12. :ref:`publish_documentation`

.. _update_release_notes:

Update the Release Notes
-------------------------

The release notes file called RELEASE.rst should be updated to outline what changes/fixes are in the new release. The date, version number, and other information should all be included.

SpyDrNet_SHREC uses a Major.Minor.Bug versioning scheme where minor version updates do not break the existing API and major version updates may break it. Bug fixes do not add substantial new functionality, but rather fix broken functionality. For more information, see `Semantic Versioning <https://medium.com/fiverr-engineering/major-minor-patch-a5298e2e1798>`_.

.. _update_documentation:

Update the Documentation
--------------------------

Sphinx pulls from doc strings as well as .rst files to build documentation. The documentation is built using a makefile in the docs folder.

Before building the documentation run `make clean` to clear away the old files.

Before proceeding, ensure that both of the following are successful (make they execute without errors. Try to minimize the warnings as well):

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

Be sure you are on the master branch.

Tags are used to label the release. When all changes are merged into the master branch, create a new tag.
In the examples below, replace 1.0.0 with the version number you are releasing.

**To see the current version number**

>>> git describe

**Creation**

>>> git tag -a v1.0.0 -m "SpyDrNetSHREC 1.0.0"

**Push your changes to the tags**

>>> git push --tags

A tag may need to be updated if a new commit is pushed to the branch (because the tag will be left on the previous commit) or if you simply mess up. Do the following to force update the tag.

**Updating**

>>> git tag -a v1.0.0 -m "SpyDrNet SHREC 1.0.0" -f

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

spydrnet/build and spydrnet/dist

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

The release should be named `SpyDrNet SHREC 1.0.0` where 1.0.0 is replaced with the
proper release number.

Enter a description--it could just be a reiteration of the release notes or other relevant information.

Three files need to be added as assets to the new release:
    The two files that were generated during :ref:`build_package` (a tar.gz file and a .whl file).

    The Reference PDF - download the `spydrnet_shrec_reference.pdf` found in the docs/latex folder. Rename it to `spydrnet_shrec_reference-new_release_number.pdf`. If the pdf file doesn't exist, run `make latexpdf` in the /docs folder again.

.. _publish_documentation:

Publish the Documentation
--------------------------

Currently, the source for the documentation online is found at `//<CAEDM_DRIVE>/<USERNAME>/groups/ccl/www/spydrnet-shrec/docs`. 

Make a new folder inside this directory named after the version number (e.g. 1.0.0) with the new html files. `latest` is a softlink that points to the latest version of the documentation. Update the softlink to point to the new folder you just created with the most recent documentation.

Check which version of the documentation the softlink points to

>>> ls -lha

to update the softlink remove it first (watch syntax here very carefully, a
terminating \ could make the command delete the folder's contents instead of the
link)

>>> rm latest

then create a link to the new folder

>>> ln -s version.number latest

The `latest` folder should now point to the folder you just created, and the online documentation should show up as updated.