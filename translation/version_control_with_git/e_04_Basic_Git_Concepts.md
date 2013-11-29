# CHAPTER 4: Basic Git Concepts

## Basic Concepts

The previous chapter presented a typical application of Git and probably sparked 
a good number of questions. Does Git store the entire file at every commit? 
What’s the purpose of the .git directory? 
Why does a commit ID resemble gibberish? 
Should I take note of it?
If you’ve used another version control system (VCS), such as Subversion or CVS, 
the commands in the last chapter likely seemed familiar. 
Indeed, Git serves the same function and provides 
all the operations you expect from a modern VCS. 
However, Git differs in some fundamental and surprising ways.
In this chapter, we explore why and where Git differs by examining 
the key components of its architecture and some important concepts. 
Here we focus on the basics and demonstrate how to interact with one repository. 
Chapter 11 explains how to work with many interconnected repositories. 
Keeping track of multiple repositories may seem like a daunting prospect, 
but the fundamentals you learn in this chapter apply just the same.

### Repositories

A Git repository is simply a database containing all the information needed to retain and manage the revisions and history of a project. 
In Git, as with most version control systems, a repository retains a complete copy of the entire project throughout its lifetime. 
However, unlike most other VCSs, the Git repository provides not only a complete working copy of all the files in the repository but also a copy of the repository itself with which to work.
Git maintains a set of configuration values within each repository. 
You saw some of these, such as the repository user’s name and email address, in the previous chapter. 
Unlike file data and other repository metadata, configuration settings are not propagated from one repository to another during a clone, or duplicating, operation. 
Instead, Git manages and inspects configuration and setup information on a per-site, per-user, and per-repository basis.
Within a repository, Git maintains two primary data structures, the object store and the index. All of this repository data is stored at the root of your working directory in a hidden subdirectory named .git.
The object store is designed to be efficiently copied during a clone operation as part of the mechanism that supports a fully distributed VCS. 
The index is transitory information, is private to a repository, and can be created or modified on demand as needed.
The next two sections describe the object store and index in more detail.

### Git Object Types
At the heart of Git’s repository implementation is the object store. It contains your original data files and all the log messages, author information, dates, and other information required to rebuild any version or branch of the project.
Git places only four types of objects in the object store: the blobs, trees, commits, and tags. These four atomic objects form the foundation of Git’s higher-level data structures:

*Blobs*
> Each version of a file is represented as a blob. 
> “Blob” is a contraction of “binary large object”, 
> a term that’s commonly used in computing to refer to some variable or 
> file that can contain any data and whose internal structure 
> is ignored by the program. 
> A blob is treated as opaque. 
> A blob holds a file’s data but does not contain 
> any metadata about the file or even its name.
*Trees*
> A tree object represents one level of directory information. 
> It records blob identifiers, pathnames, 
> and a bit of metadata for all the files in one directory. 
> It can also recursively reference other (sub)tree objects 
> and thus build a complete hierarchy of files and subdirectories.

*Commits*
> A commit object holds metadata for each change introduced into the repository, including the author, committer, commit date, and log message 
> Each commit points to a tree object that captures, in one complete snapshot, the state of the repository at the time the commit was performed. The initial commit, or root commit, has no parent. Most commits have one commit parent, though in Chapter 9, I explain how a commit can reference more than one parent.

*Tags*
> A tag object assigns an arbitrary yet presumably human-readable name to a specific object, usually a commit. Although 9da581d910c9c4ac93557ca4859e767f5caf5169 refers to an exact and well-defined commit, a more familiar tag name like Ver-1.0- Alpha might make more sense!

Over time, all the information in the object store changes and grows, tracking and modeling your project edits, additions, and deletions. To use disk space and network bandwidth efficiently, Git compresses and stores the objects in pack files, which are also placed in the object store.

### Index

The index is a temporary and dynamic binary file that describes the directory structure of the entire repository. More specifically, the index captures a version of the project’s overall structure at some moment in time. The project’s state could be represented by a commit and a tree from any point in the project’s history, or it could be a future state toward which you are actively developing.
One of the key distinguishing features of Git is that it enables you to alter the contents of the index in methodical, well-defined steps. The index allows a separation between incremental development steps and the committal of those changes.
Here’s how it works. As the developer, you execute Git commands to stage changes in the index. Changes usually add, delete, or edit some file or set of files. The index records and retains those changes, keeping them safe until you are ready to commit them. You can also remove or replace changes in the index. Thus, the index allows a gradual transition, usually guided by you, from one complex repository state to another, presumably better state.
As you’ll see in Chapter 9, the index plays an important role in merges, allowing multiple versions of the same file to be managed, inspected, and manipulated simultaneously.

### Content-Addressable Names
The Git object store is organized and implemented as a content-addressable storage system. Specifically, each object in the object store has a unique name produced by applying SHA1 to the contents of the object, yielding an SHA1 hash value. Since the complete contents of an object contribute to the hash value and since the hash value is believed to be effectively unique to that particular content, the SHA1 hash is a sufficient index or name for that object in the object database. Any tiny change to a file causes the SHA1 hash to change, causing the new version of the file to be indexed separately.
SHA1 values are 160-bit values that are usually represented as a 40-digit hexadecimal number, such as `9da581d910c9c4ac93557ca4859e767f5caf5169`. Sometimes, during display, SHA1 values are abbreviated to a smaller, unique prefix. Git users speak of SHA1, hash code, and sometimes object ID interchangeably.
	== Globally Unique Identifiers ==
	An important characteristic of the SHA1 hash computation is that it 
	always computes the same ID for identical content, regardless of where 
	that content is. In other words, the same file content in different 
	directories and even on different machines yields the exact same SHA1 
	hash ID. Thus, the SHA1 hash ID of a file is a globally unique identifier.
	A powerful corollary is that files or blobs of arbitrary size can be
	compared for equality across the Internet by merely comparing their 
	SHA1 identifiers.
	
### Git Tracks Content

It’s important to see Git as something more than a version control system: 
Git is a content tracking system. 
This distinction, however subtle, 
guides much of the design of Git and is perhaps 
the key reason Git can perform internal data manipulations with relative ease. 
Yet this is also perhaps one of the most difficult concepts for new users of Git to grasp, 
so some exposition is worthwhile.
Git’s content tracking is manifested in two critical ways 
that differ fundamentally from almost all other* revision control systems.
First, Git’s object store is based on the hashed computation of the contents of its objects,
not on the file or directory names from the user’s original file layout. 
Thus, when Git places a file into the object store, 
it does so based on the hash of the data and not on the name of the file. 
In fact, Git does not track file or directory names, 
which are associated with files in secondary ways. 
Again, Git tracks content instead of files.
If two separate files located in two different directories have exactly the same content, 
Git stores a sole copy of that content as a blob within the object store. 
Git computes the hash code of each file according solely to its content, 
determines that the files have the same SHA1 values and thus the same content, 
and places the blob object in the object store indexed by that SHA1 value. 
Both files in the project, 
regardless of where they are located in the user’s directory structure, 
use that same object for content.
If one of those files changes, Git computes a new SHA1 for it, 
determines that it is now a different blob object,
and adds the new blob to the object store. 
The original blob remains in the object store for the unchanged file to use.
Second, Git’s internal database efficiently stores every version 
of every file not their differences as files go from one revision to the next. 
Because Git uses the hash of a file’s complete content as the name for that file, 
it must operate on each complete copy of the file. 
It cannot base its work or its object store entries on only part of the file’s content, 
nor on the differences between two revisions of that file.
The typical user view of a file that it has revisions and appears to 
progress from one revision to another revision is simply an artifact.
Git computes this history as a set of changes between different blobs with varying hashes, 
rather than storing a filename and set of differences directly. 
It may seem odd, but this feature allows Git to perform certain tasks with ease.


### Pathname Versus Content
As with many other VCSs, Git needs to maintain an explicit list of files that 
form the content of the repository. 
However, this does not require that Git’s manifest be based on filenames. 
Indeed, Git treats the name of a file as a piece of data that is distinct 
from the contents of that file. 
In this way, it separates “index” from “data” in the traditional database sense. 
It may help to look at Table 4-1, which roughly compares Git to other familiar systems.
*Table 4-1. Database comparison*
System ￼ ￼ ￼ ￼           | Index mechanism            ￼ ￼ ￼| Data store
---------------------|------------------------------|--------------
￼￼Traditional database | ISAM                         | Data records
Unix filesystem      | Directories (/path/to/file)  | Blocks of data
Git       | .git/objects/hash, tree object contents | Blob objects, tree objects


## Object Store Pictures

Let’s look at how Git’s objects fit and work together to form the complete system.
The blob object is at the “bottom” of the data structure; 
it references nothing and is referenced only by tree objects. 
In the figures that follow, each blob is represented by a rectangle.
Tree objects point to blobs, and possibly to other trees as well. 
Any given tree object might be pointed at by many different commit objects. 
Each tree is represented by a triangle.
A circle represents a commit. 
A commit points to one particular tree that is introduced into the repository by the commit.
Each tag is represented by a parallelogram. Each tag can point to at most one commit.
The branch is not a fundamental Git object, yet it plays a crucial role in naming commits. Each branch is pictured as a rounded rectangle.
Figure 4-1 captures how all the pieces fit together. 
This diagram shows the state of a repository after a single, 
initial commit added two files. 
Both files are in the top-level directory. 
Both the master branch and a tag named *V1.0* point to the commit with ID *8675309*.

![](figure_4-1.Git_objects.png)

Now, let’s make things a bit more complicated. 
Let’s leave the original two files as is, 
adding a new subdirectory with one file in it. 
The resulting object store looks like Figure 4-2.
As in the previous picture, the new commit has added one associated tree object 
to represent the total state of directory and file structure. 
In this case, it is the tree object with ID *cafed00d*.
![](figure_4-2.Git_objects_after_second_commit.png)
Since the top-level directory is changed by the addition of the new subdirectory, 
the content of the top-level tree object has changed as well, 
so Git introduces a new tree, *cafed00d*.
However, the blobs *dead23* and *feeb1e* didn’t change from the first commit to the second. 
Git realizes that the IDs haven’t changed and thus can be directly referenced 
and shared by the new cafed00d tree.

Pay attention to the direction of the arrows between commits. 
The parent commit or commits come earlier in time. 
Therefore, in Git’s implementation, each commit points back to its parent or parents. 
Many people get confused because the state of a repository is 
conventionally portrayed in the opposite direction: 
as a dataflow from the parent commit to child commits.
In Chapter 6, we extend these pictures to show how the history of a repository 
is built up and manipulated by various commands.


## Git Concepts at Work
With some tenets out of the way, let’s see how all these concepts and components fit together in the repository itself. Let’s create a new repository and inspect the internal files and object store in much greater detail.
### Inside the .git directory

To begin, initialize an empty repository using `git init` and then run `find` to reveal what’s created:

	$ mkdir /tmp/hello
	$ cd /tmp/hello
	$ git init
	Initialized empty Git repository in /tmp/hello/.git/
	# List all the files in the current directory 
	$ find .
	.
	./.git
	./.git/hooks 
	./.git/hooks/commit-msg.sample 
	./.git/hooks/applypatch-msg.sample 
	./.git/hooks/pre-applypatch.sample 
	./.git/hooks/post-commit.sample 
	./.git/hooks/pre-rebase.sample 
	./.git/hooks/post-receive.sample 
	./.git/hooks/prepare-commit-msg.sample 
	./.git/hooks/post-update.sample 
	./.git/hooks/pre-commit.sample 
	./.git/hooks/update.sample
	./.git/refs
	./.git/refs/heads
	./.git/refs/tags
	./.git/config
	./.git/objects
	./.git/objects/pack ./.git/objects/info
	./.git/description
	./.git/HEAD
	./.git/branches
	./.git/info
	./.git/info/exclude

As you can see, *.git* contains a lot of stuff. All of the files are based on a template directory that you can adjust, if you so choose. Depending on the version of Git you are using, your actual manifest may look a little different.For example, older versions of Git do not use a *.sample* suffix on 
the *.git/hooks* files. 
In general, you don’t have to view or manipulate the files in *.git*. These “hidden” files are considered part of Git’s plumbing, or configuration. Git has a small set of plumbing commands to manipulate these hidden files, but you will rarely use them.
Initially, the *.git/objects* directory (the directory for all of Git’s objects) is empty, except for a few placeholders:

	$ find .git/objects
	.git/objects 
	.git/objects/pack 
	.git/objects/info

Let’s now carefully create a simple object:

	$ echo "hello world" > hello.txt 
	$ git add hello.txt

If you typed “hello world” exactly as it appears here (with no changes to spacing or capitalization), your objects directory should now look like this:

	$ find .git/objects
	.git/objects
	.git/objects/pack
	.git/objects/3b 
	.git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad 
	.git/objects/info

All this looks mysterious. But it’s not, as the following sections explain.

### Objects, Hashes, and Blobs
When it creates an object for hello.txt, Git doesn’t care that the filename is hello.txt. Git cares only about what’s inside the file: the sequence of 12 bytes that represent “hello world” and the terminating newline (the same blob created earlier). Git performs a few operations on this blob, calculates its SHA1 hash, and enters it into the object store as a file named after the hexadecimal representation of the hash.

	How Do We Know a SHA1 Hash Is Unique?
	
	There is an extremely slim chance that two different blobs yield the same SHA1 hash. 
	When this happens, it is called a collision. 
	However, SHA1 collision is so unlikely that you can safely bank on 
	it never interfering with our use of Git.
	
	SHA1 is a cryptographically secure hash. 
	Until recently there was no known way (better than blind luck) 
	for a user to cause a collision on purpose. 
	But could a collision happen at random? Let’s see.
	
	With 160 bits, you have 2160, or about 1048 (1 with 48 zeros after it), 
	possible SHA1 hashes. 
	That number is just incomprehensibly huge. 
	Even if you hired a trillion people to produce a trillion new unique 
	blobs per second for a trillion years, 
	you would still only have about 1043 blobs.
	
	If you hashed 280 random blobs, you might find a collision. 
	
	Don’t trust us. Go read Bruce Schneier.

The hash in this case is 3b18e512dba79e4c8300dd08aeb37f8e728b8dad. The 160 bits of an SHA1 hash correspond to 20 bytes, which takes 40 bytes of hexadecimal to display, so the content is stored as .git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad. Git inserts a / after the first two digits to improve filesystem efficiency. (Some filesystems slow down if you put too many files in the same directory; making the first byte of the SHA1 into a directory is an easy way to create a fixed, 256-way partitioning of the namespace for all possible objects with an even distribution.)

To show that Git really hasn’t done very much with the content in the file (it’s still the same comforting “hello world”), you can use the hash to pull it back out of the object store any time you want:

	$ git cat-file -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 
	hello world

> Git also knows that 40 characters is a bit chancy to type by hand, 
> so Git provides a command to look up objects by a unique prefix of the object hash:
	$ git rev-parse 3b18e512d 
	3b18e512dba79e4c8300dd08aeb37f8e728b8dad























