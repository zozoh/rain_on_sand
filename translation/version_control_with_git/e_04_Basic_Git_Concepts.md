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

> **Globally Unique Identifiers**
> 
> An important characteristic of the SHA1 hash computation is that it 
> always computes the same ID for identical content, regardless of where 
> that content is. In other words, the same file content in different 
> directories and even on different machines yields the exact same SHA1 
> hash ID. Thus, the SHA1 hash ID of a file is a globally unique identifier.
> A powerful corollary is that files or blobs of arbitrary size can be
> compared for equality across the Internet by merely comparing their 
> SHA1 identifiers.
> 

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

System ￼ ￼ ￼ ￼       | Index mechanism         ￼ ￼ ￼| Data store
---------------------|------------------------------|--------------
Traditional database | ISAM                         | Data records
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
With some tenets out of the way, let’s see how all these concepts and components fit together in the repository itself. 
Let’s create a new repository and inspect the internal files 
and object store in much greater detail.

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

As you can see, *.git* contains a lot of stuff. 
All of the files are based on a template directory that you can adjust, 
if you so choose. Depending on the version of Git you are using, 
your actual manifest may look a little different.For example, 
older versions of Git do not use a *.sample* suffix on the *.git/hooks* files. 
In general, you don’t have to view or manipulate the files in *.git*. 
These “hidden” files are considered part of Git’s plumbing, or configuration. 
Git has a small set of plumbing commands to manipulate these hidden files, 
but you will rarely use them.
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

When it creates an object for *hello.txt*, 
Git doesn’t care that the filename is *hello.txt*. 
Git cares only about what’s inside the file: 
the sequence of 12 bytes that represent “hello world” 
and the terminating newline (the same blob created earlier). 
Git performs a few operations on this blob, 
calculates its SHA1 hash, 
and enters it into the object store as a file 
named after the hexadecimal representation of the hash.

> **How Do We Know a SHA1 Hash Is Unique?**
> 
> There is an extremely slim chance that two different blobs yield the 
> same SHA1 hash. When this happens, it is called a collision. 
> However, SHA1 collision is so unlikely that you can safely bank on 
> it never interfering with our use of Git.
> 
> SHA1 is a cryptographically secure hash. 
> Until recently there was no known way (better than blind luck) 
> for a user to cause a collision on purpose. 
> But could a collision happen at random? Let’s see.
> 
> With 160 bits, you have 2160, or about 1048 (1 with 48 zeros after it), 
> possible SHA1 hashes. 
> That number is just incomprehensibly huge. 
> Even if you hired a trillion people to produce a trillion new unique 
> blobs per second for a trillion years, 
> you would still only have about 1043 blobs.
> 
> If you hashed 280 random blobs, you might find a collision. 
> 
> Don’t trust us. Go read Bruce Schneier.
> 

The hash in this case is *3b18e512dba79e4c8300dd08aeb37f8e728b8dad*. 
The 160 bits of an SHA1 hash correspond to 20 bytes, 
which takes 40 bytes of hexadecimal to display, 
so the content is stored as 
`.git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad`. 
Git inserts a `/` after the first two digits to improve filesystem efficiency. (Some filesystems slow down if you put too many files in the same directory; making the first byte of the SHA1 into a directory is an easy way to create a fixed, 256-way partitioning of the namespace for all possible objects with an even distribution.)

To show that Git really hasn’t done very much with the content in the file (it’s still the same comforting “hello world”), you can use the hash to pull it back out of the object store any time you want:

	$ git cat-file -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 
	hello world

> Git also knows that 40 characters is a bit chancy to type by hand, 
> so Git provides a command to look up objects 
> by a unique prefix of the object hash:

	$ git rev-parse 3b18e512d 
	3b18e512dba79e4c8300dd08aeb37f8e728b8dad

### Files and Trees

Now that the “hello world” blob is safely ensconced in the object store, 
what happens to its filename? 
Git wouldn’t be very useful if it couldn’t find files by name.

As mentioned earlier, 
Git tracks the pathnames of files through another kind of object 
called a *tree*. When you use **git add**, 
Git creates an object for the contents of each file you add, 
but it doesn’t create an object for your *tree* right away. 
Instead, it updates the index. 
The index is found in *.git/index* and keeps track of file pathnames 
and corresponding blobs. 
Each time you run commands such as 
**git add**, **git rm**, or **git mv**, 
Git updates the index with the new pathname and blob information.

Whenever you want, you can create a *tree* object from your current index by capturing a snapshot of its current information with the low-level git write-tree command.

At the moment, the index contains exactly one file, *hello.txt*:

	$ git ls-files -s
	100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0 hello.txt

Here you can see the association of the file *hello.txt* 
and the blob *3b18e5...*. 

Next, let’s capture the index state and save it to a *tree* object:

	$ git write-tree 68aba62e560c0ebc3396e8ae9335232cd93a3f60
	$ find .git/objects
	.git/objects
	.git/objects/68 .git/objects/68/aba62e560c0ebc3396e8ae9335232cd93a3f60 
	.git/objects/pack
	.git/objects/3b .git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad 
	.git/objects/info

Now there are two objects, the “hello world” object at *3b18e5* and a new one, the *tree* object, at *68aba6*. 
As you can see, the SHA1 object name corresponds exactly 
to the subdirectory and filename in *.git/objects*.

But what does a *tree* look like? 
Because it’s an object, just like the blob, 
you can use the same low-level command to view it:

	$ git cat-file -p 68aba6
	100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad hello.txt

The contents of the object should be easy to interpret. 
The first number, *100644*, 
represents the file attributes of the object in octal, 
which should be familiar to anyone who has used the Unix **chmod** command. 
Here *3b18e5* is the object name of the “hello world” blob, 
and *hello.txt* is the name associated with that blob.

It is now easy to see that the *tree* object has captured the information that was in the index when you run **git ls-files -s**.

### A Note on Git’s Use of SHA1

Before peering at the contents of the *tree* object in more detail, 
let’s check out an important feature of SHA1 hashes:

	$ git write-tree
	68aba62e560c0ebc3396e8ae9335232cd93a3f60
	
	$ git write-tree
	68aba62e560c0ebc3396e8ae9335232cd93a3f60
	
	$ git write-tree
	68aba62e560c0ebc3396e8ae9335232cd93a3f60

Every time you compute another *tree* object for the same index, 
the SHA1 hash remains exactly the same. 
Git doesn’t need to recreate a new *tree* object. 
If you’re following these steps at the computer, 
you should be seeing exactly the same SHA1 hashes 
as the ones published in this book.

In this sense, the hash function is a true function 
in the mathematical sense: 
for a given input, it always produces the same output. 
Such a hash function is sometimes called a **digest** to emphasize 
that it serves as a sort of summary of the hashed object. 
Of course, any hash function, 
even the lowly parity bit, has this property.

That’s extremely important. 
For example, if you create the exact same content as an other developer, regardless of where or when or how both of you work, 
an identical hash is proof enough that the full content is identical, too. 
In fact, Git treats them as identical.

But hold on a second aren’t SHA1 hashes unique? 
What happened to the trillions of people with trillions of blobs per second who never produce a single collision? 
This is a common source of confusion among new Git users. 
So read on carefully, because if you can understand this distinction, 
everything else in this chapter is easy.

Identical SHA1 hashes in this case do not count as a collision. 
It would be a collision only if two different objects produced the same hash. Here, you created two separate instances of the very same content, 
and the same content always has the same hash.

Git depends on another consequence of the SHA1 hash function: 
it doesn’t matter how you got a tree called 
*68aba62e560c0ebc3396e8ae9335232cd93a3f60*. 
If you have it, you can be extremely confident it is the same tree object
another reader of this book has. 
Bob might have created the tree by combining commits A and B 
from Jennie and commit C from Sergey, 
whereas you got commit A from Sue and an update from Lakshmi 
that combines commits B and C. 
The results are the same, and this facilitates distributed development.

If you look for object *68aba62e560c0ebc3396e8ae9335232cd93a3f60* 
and can find it, 
then you can be confident that you are looking at precisely the same data 
from which the hash was created (because SHA1 is a cryptographic hash).

The converse is also true: if you don’t find an object with a specific hash in your object store, you can be confident that you do not hold a copy of that exact object.

Thus, you can determine whether your object store does or does not have a particular object even though you know nothing about its (potentially very large) contents. The hash thus serves as a reliable “label” or name for the object.

But Git also relies on something stronger than that conclusion, too. 
Consider the most recent commit (or its associated *tree* object). 
Since it contains, as part of its content, 
the hash of its parent commits and of its tree, 
and since that in turn contains the hash of all of its subtrees and blobs, 
recursively through the whole data structure, 
it follows by induction that the hash of the original commit uniquely 
identifies the state of the whole data structure rooted at that commit.

Finally, the implications of my claim in the previous paragraph 
lead to a powerful use of the hash function: 
it provides an efficient way to compare two objects, 
even two very large and complex data structures,
without transmitting either in full.

### Tree Hierarchies

It’s nice to have information regarding a single file, as was shown in the previous section, but projects contain complex, deeply nested directories that are refactored and moved around over time. Let’s see how Git handles this by creating a new subdirectory that contains an identical copy of the hello.txt file:

	$ pwd
	/tmp/hello
	$ mkdir subdir
	$ cp hello.txt subdir/
	$ git add subdir/hello.txt
	$ git write-tree 
	492413269336d21fac079d4a4672e55d5d2147ac

	$ git cat-file -p 4924132693
	100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad hello.txt
	040000 tree 68aba62e560c0ebc3396e8ae9335232cd93a3f60 subdir

The new top-level tree contains two items: 
the original *hello.txt* file as well as the new *subdir* directory, 
which is of type *tree* instead of *blob*.

Notice anything unusual? Look closer at the object name of *subdir*. 
It’s your old friend, *68aba62e560c0ebc3396e8ae9335232cd93a3f60*!

What just happened? 
The new tree for *subdir* contains only one file, *hello.txt*, 
and that file contains the same old “hello world” content. 
So the *subdir* tree is exactly the same as the older, top-level tree! 
And of course it has the same SHA1 object name as before.

Let’s look at the *.git/objects* directory 
and see what this most recent change affected:

	$ find .git/objects
	.git/objects
	.git/objects/49 .git/objects/49/2413269336d21fac079d4a4672e55d5d2147ac 
	.git/objects/68 .git/objects/68/aba62e560c0ebc3396e8ae9335232cd93a3f60 
	.git/objects/pack
	.git/objects/3b .git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad 
	.git/objects/info

There are still only three unique objects: 
a *blob* containing “hello world”; 
a tree containing *hello.txt*, 
which contains the text “hello world” plus a newline; 
and a second tree that contains another reference to *hello.txt* 
along with the first tree.

### Commits

The next object to discuss is the *commit*. 
Now that *hello.txt* has been added with **git add** 
and the tree object has been produced with git write-tree, 
you can create a *commit* object using low-level commands like this:

	$ echo -n "Commit a file that says hello\n" \
		| git commit-tree 492413269336d21fac079d4a4672e55d5d2147ac
	3ede4622cc241bcb09683af36360e7413b9ddf6c

And it will look something like this:

	$git cat-file -p 3ede462
	author Jon Loeliger <jdl@example.com> 1220233277 -0500 committer Jon Loeliger <jdl@example.com> 1220233277 -0500

	Commit a file that says hello

If you’re following along on your computer, 
you probably found that the commit object you generated does not 
have the same name as the one in this book. 
If you’ve understood everything so far, 
the reason for that should be obvious: 
it’s not the same commit. 
The commit contains your name and the time you made the commit, 
so of course it is different, however subtly. 
On the other hand, your commit does have the same tree. 
This is why commit objects are separate from their tree objects: 
different commits often refer to exactly the same tree. 
When that happens, Git is smart enough to transfer around 
only the new commit object which is tiny instead of 
the *tree* and *blob* objects, which are probably much larger.

In real life, you can (and should!) 
skip the low-level **git write-tree** and **git commit-tree** steps 
and just use the **git commit** command. 
You don’t need to remember all those plumbing commands 
to be a perfectly happy Git user.

A basic commit object is fairly simple, 
and it’s the last ingredient required for a real revision control system. 
The commit object just shown is the simplest possible one, containing:

* The name of a tree object that actually identifies the associated files
* The name of the person who composed the new version (the author) and the time when it was composed
* The name of the person who placed the new version into the repository (the committer) and the time when it was committed
* A description of the reason for this revision (the commit message)

By default, the author and committer are the same; 
there are a few situations where they’re different.

> You can use the command git show --pretty=fuller 
> to see additional details about a given commit.

Commit objects are also stored in a graph structure, 
although it’s completely different from the structures used by tree objects.
When you make a new commit, you can give it one or more parent commits. 
By following back through the chain of parents, 
you can discover the history of your project. 
More details about commits and the commit graph are given in Chapter 6.

### Tags

Finally, the last object Git manages is the *tag*. 
Although Git implements only one kind of tag object, 
there are two basic tag types, 
usually called *lightweight* and *annotated*.

Lightweight tags are simply references to a commit object 
and are usually considered private to a repository. 
These tags do not create a permanent object in the object store. 
An *annotated* tag is more substantial and creates an object. 
It contains a message, supplied by you, 
and can be digitally signed using a *GnuPG key*, 
according to *RFC4880*.

Git treats both *lightweight* and *annotated* tag names equivalently 
for the purposes of naming a commit. 
However, by default, many Git commands work only on annotated tags, 
as they are considered “permanent” objects.

You create an *annotated*, unsigned tag with a message 
on a commit using the **git tag** command:

	$ git tag -m"Tag version 1.0" V1.0 3ede462

You can see the tag object via the **git cat-file -p** command, 
but what is the SHA1 of the tag object? 
To find it, use the tip from “Objects, Hashes, and Blobs” on page 37.

	$ git rev-parse V1.0 
	6b608c1093943939ae78348117dd18b1ba151c6a

	$ git cat-file -p 6b608c
	object 3ede4622cc241bcb09683af36360e7413b9ddf6c
	type commit
	tag V1.0
	tagger Jon Loeliger <jdl@example.com> Sun Oct 26 17:07:15 2008 -0500
	
	Tag version 1.0

In addition to the log message and author information, 
the tag refers to the commit object *3ede462*. 
Usually, Git tags a particular commit as named by some branch. 
Note that this behavior is notably different from that of other VCSs.

Git usually tags a commit object, which points to a tree object, 
which encompasses the total state of the entire hierarchy of files 
and directories within your repository.

Recall from Figure 4-1 that the *V1.0* tag points to the commit named *1492*,
which in turn points to a tree (*8675309*) that spans multiple files. 
Thus, the tag simultaneously applies to all files of that tree.

This is unlike CVS, for example, 
which will apply a tag to each individual file 
and then rely on the collection of all those tagged files 
to reconstitute a whole tagged revision. 
And whereas CVS lets you move the tag on an individual file, 
Git requires a new commit, encompassing the file state change, 
onto which the tag will be moved.




































