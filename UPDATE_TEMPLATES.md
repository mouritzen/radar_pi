updates-templates README
========================

The script update-templates can be used to update a plugin with
newer versions of the shipdriver templates. The basic workflow
is to
  - If keys exist in the ./ci folder copy them to ./build-deps. If not they will be removed in the update process.
  - Make sure the plugin repo is clean (commit or stash changes)
  - Bootstrap process by downloading script and add it to repo.
  - Pin files which should not be updated.
  - Run script
  - Inspect the results, handle possible conflicts and commit the
    changes.
  - Handle updates to CMakeLists.txt and other plugin-specific files.
  - Upstream local changes to shipdriver templates

Bootstrapping
-------------
Only required if the update script is yet not part of the repo. Once
installed, the script is self-updating.

Linux:

    $ cd some_plugin
    $ repo=https://raw.githubusercontent.com/Rasbats/shipdriver_pi/master
    $ curl $repo/update-templates --output update-templates
    $ chmod 755 update-templates
    $ git add update-templates
    $ git commit -m "Add update-templates script"

It is also possible to use wget instead of curl, like
`wget $repo/update-templates`. Windows works the same way, except that
the `chmod` command does not make sense here and hence is omitted.


Bootstrap - Windows
-------------------

As in linux, bootstrapping is only required if the script is yet not
available in the plugin repo. Once installed, it's self-updating.

The script is written in bash, so git-bash is required. Using git-bash, the
script can be downloaded and installed as in linux, see above.

Using the Windows command CLI goes like:

    > cd some_plugin
    > set repo=https://raw.githubusercontent.com/Rasbats/shipdriver_pi/master
    > curl %repo%/update-templates --output update-templates
    > git add update-templates
    > git commit -m "Add update-templates script"


Pin files which should not be updated
-------------------------------------

If there are files which are known to have local modifications, list these
files (one per line) in a file named *update-ignored*.  This file is not
present by default, and needs to be created and committed if used.


Running
-------

The script is run from the plugin top directory using
`./update-templates`. In windows, assuming standard installation paths:

    > "C:\Program Files\Git\bin\bash.exe" update-templates

Usage summary:

    update-templates [-T | -h] [treeish]

The *treeish* argument can be used to merge changes from another shipdriver
branch than the default shipdriver/master.

_-T_ runs in test mode, lots of output, requires an existing remote and
does not self-update.

*update-templates -h* prints the complete help message.

Script unconditionally updates known files and commits them directly.

Checking modifications in CMakeLists.txt and flatpak manifest
-------------------------------------------------------------

Besides the changes in generic files, CMakeLists.txt typically also needs to
be updated. However, this file is specific for each plugin, and changes must
be applied manually.

The changes made in shipdriver's CMakeLists.txt is a good starting point to
check. Af running the script these changes are appended as a comment to
CMakeLists.txt. Reviewing these changes should give a good hint about the
changes needed. After review, remove the diff comment.


Upstreaming local changes to shipdriver
---------------------------------------
After resolving conflicts, please consider upstreaming local changes which
to the shipdriver templates using a PR so that next update runs
smoother.
