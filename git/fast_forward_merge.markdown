## Fast-Forward Merge

For the years I have used `git` and performed countless merges, I had always wondered what the occasional mention of `Fast-Forward` in the standard output meant. In case you have ever wondered what `git` is trying to tell you when this happens, I did some digging.

### An Example

As always, I feel explaining `git` concepts requires some visualization aid. Let's say that we have the following commit history for our `master` branch:

![master branch consisting of three commits](https://git-scm.com/book/en/v2/images/basic-branching-1.png "Simple commit history.")

Now, you've been tasked with fixing a bug. To do so, you create a new branch to make your bug fix in. For the sake of this example, let's say that the issue you are fixing has been assigned the number 53, so you name this new branch `iss53`:

```bash
$ git checkout -b iss53
```

Before you have committed any changes in your feature branch (  `iss53`), both the `master` branch and the `iss53` branch are pointing to the same commit (`C2` in this visual).

![master branch and iss53 branch pointing to same commit](https://git-scm.com/book/en/v2/images/basic-branching-2.png "Creating a new branch pointer.")

As the diagram illustrates, you can essentially think of a branch as a pointer to single commit. In fact, the commit that the branch is pointing to is the last commit made in that branch. At the current moment, we have not made any additional commits to our `iss53` branch, so it is still pointing at the commit from which we created our branch, `C2`.

Okay, now the fun part; let's fix that bug!

The change was relatively simple, so it only required a single commit. Once we have committed that change in our `iss53` branch, the commit history and branch pointers look like this:

![add a new commit on the iss53 branch](https://git-scm.com/book/en/v2/images/basic-branching-3.png "Branch iss53 moved forward with new commit.")

Alright. We have tested our bug fix, and everything looks good! Time to merge our change into the `master` branch. To do this, we have to switch into our `master` branch first.

```bash
$ git checkout master
```

Now, we merge in the `iss53` branch.

```bash
$ git merge iss53
```

Once we issue the `merge` command, we see that `git` begins printing to standard output:

```
Updating f42c576..3a0874c
Fast-forward
 index.html | 2 ++
 1 file changed, 2 insertions(+)
```

There it is! We just performed a fast-forward merge!

### Explanation

Now that we have had an example with some visuals, and have been able to perform a fast-forward merge, let's do a little deeper dive on what a fast-forward merge is and what conditions have to be present for `git` to perform one.

A fast-forward merge is a merge that can be completed successfully by just moving the branch pointer of the checked out branch (the branch that you have switched to prior to running the `merge` command; the branch receiving the commits of another branch) to the last commit of the incoming branch. Essentially, if the latest commit of the checked out branch is a direct ancestor of the latest commit of the incoming branch, a fast-forward merge can be performed.

To put it more simply, a fast-forward merge is a merge that doesn't actually involve merging any divergent work together. Instead, the commits being "merged" in are simply appended to the end of the last commit of the checked out branch (`master` in this case). Relating back to some of the visuals provided in the example, another way of thinking about it is just moving the branch pointer for `master` to the last commit of the `iss53` branch. This is where the terminology of "fast-forward" came to be, since there is no additional merging needed, and all that is needed is for the pointer to the latest commit in the checked out branch to be moved forward to the latest commit of the incoming branch.

### Other Merges

So what happens when someone else that you are collaborating with merges their branch to `master` while you are still working on your branch?

![commits added to master while still working on iss53](https://git-scm.com/book/en/v2/images/basic-branching-6.png "Diverged work added to master while working on iss53.")

Here you can see that the commit `C4` has been merged into the `master` branch while we were still working our `iss53` branch. Once we were done with our changes in the `iss53` branch and went to merge our branch into the `master` branch, `git` displayed the following:

```
Merge made by the 'recursive' strategy.
index.html |    1 +
1 file changed, 1 insertion(+)
```

No fast-forward?! What happened?

Due to the fact that that additional commits were merged into `master` since creating the `iss53` branch (referred to as "diverging"), `git` cannot simply move the branch pointer of the checked out branch (`master`) to the last commit of the incoming branch (`iss53`). Since the `iss53` branch was based on an earlier commit (`C2` as labeled in the visual) than the last commit in `master` currently, `git` must perform some work to merge together the changes in `C4`, `C3` and `C5`. In these situations, `git` will instead perform what is a called a `three-way merge`.

To learn more about the scenarios that prevent a fast-forward merge from occuring, check out the brain dump on three-way merges, or hit the official [git documents](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging).
