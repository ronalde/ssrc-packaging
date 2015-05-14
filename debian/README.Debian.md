Debian packaging README for ssrc
================================

This package adheres to the workflow described in PackagingWithGit[a],
and the branch layout is as recommended by the git-buildpackage
manual[b]. The debian packages are build manually, after which the
Ubuntu packages are build automatically through a daily build recipe
in Launchpad[c]. The upstream and packaging code is maintained in the
ssrc-packaging repository on github[d].


1. Updates to the packaging code
--------------------------------

When the packaging code (in the directory `./debian') should be
updated, perform the following steps:

1.1  Clone the git repository, preferably in a clean debian stable
     build environment (using pbuilder).

       git clone https://github.com/ronalde/ssrc-packaging.git

1.2  Install dpkg-dev in the build environment.

       apt-get install dpkg-dev

1.3  When neccessary install the build dependencies for the package

       dpkg-checkbuilddeps
       apt-get install <packages displayed by dpkg-checkbuilddeps>

1.4  Make modifications to files in the `./debian' directory. Note
     that changes to upstream code --anything not in the `./debian'
     directory-- should be implemented through patches; see general
     packaging documentation in the maintainers guide [4].

1.5  When done editing, test your modifications by building the
     package with `git-buildpackage'; modify the packaging code until
     it succeeds.

       git-buildpackage

1.6  When the step above succeeds, use the debian changelog helper
     `dch' (installed with `dpkg-dev`) to increase the
     debian-packaging version number. If you use emacs as your editor,
     please install `dpkg-dev-el' first, because normal `changelog
     mode' from `emacs-goodies-el' creates incompatible changelogs.

       DEBFULLNAME="Your Name" DEBEMAIL="your@email.address" dch -i

1.7  Store your modifications in the `master' git branch.

       git commit -a -m '<describe changes, closes #XXX (github issue number)>'
       git push
   
1.8  Now use `git-buildpackage' to build the new debian version, and
     automatically creating a tagged git branch `debian/x.x.x-y`,
     where `x.x.x' is the (same) upstream revision, while `y' is the
     incremented debian package version.

       git-buildpackage --git-tag --git-ignore-new

1.9  Publish the tagged `debian/x.x.x-y' version as a new git branch.

       git push origin debian/x.x.x-y

1.10 Request a new bzr `import` at
     https://code.launchpad.net/~ssrc/ssrc/HEAD

1.11 Force new builds of the daily recipe at
     https://code.launchpad.net/~ssrc/+recipe/ssrc-daily


2. Tracking upstream changes
----------------------------

When upstream changes its code, perform the following steps to
incorporate them in your packaging code.

2.1  Repeat steps 1.1 till 1.5, untill a successful build of the
     current upstream and packaging versions using `git-buildpackage'.

2.2  Change to the repository's root directory (directly underneath
     the './debian' directory), and use `git-import-orig` with the
     `--uscan' option to detect and download upstream changes, while
     creating a tagged git branch `upstream/x.x.x', where `x.x.x' is
     the new upstream version number.

       git-import-orig --uscan --verbose
   
2.3  Modify your packaging code in `./debian' to adapt to upstream
     changes if neccessary. As a minimum, reflect the upstream version
     change in `./debian/changelog'.

       DEBFULLNAME="Your Name" DEBEMAIL="your@email.address" dch -i

2.4  Run `git-buildpackage' using both the new upstream and packaging
     code, possibly adding the `--ignore-new' switch, untill it
     succeeds.

       git-buildpackage [--ignore-new]

2.5  Push the new upstream branch.

       git push upstream/x.x.x

2.6  Repeat steps 1.7 till 1.11. 


Details of the corresponding launchpad daily build recipe
---------------------------------------------------------

The recipe contains the following:

    bzr-builder format 0.3 deb-version {debversion}~ppa{revno}

With the following assumptions:

* Ubuntu release: 15.10.1
* Upstream (code) version: 1.30
* Packaging code version: 2
* Previous launchpad build number: 6 

... will this lead to the following package name:

  ssrc-1.30-2~ppa7~ubuntu15.10.1


References
----------

Ad [a]: PackagingWithGit workflow:
        https://wiki.debian.org/PackagingWithGit

Ad [b]: Recommended branch layout from git-buildpackage documentation:
        http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.import.html#GBP.BRANCH.NAMING

Ad [c]: Launchpad daily build recipe for ssrc:
        https://code.launchpad.net/~ssrc-packaging-group/+recipe/ssrc-packaging-daily

Ad [d]: git repository on github:
        https://github.com/ronalde/ssrc-packaging

Ad [e]: Debian New Maintainers' Guide
	https://www.debian.org/doc/manuals/maint-guide/index.en.html

 -- root <root@xblade.lacocina.nl>, Thu, 14 May 2015 14:39:30 +0200
