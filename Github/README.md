Git Commands

Git configurations

```
    git --version  // to check version

    // To Set name or Email
    git config --global user.name "Your Name Here"
    git config --global user.email "Your email Here"


    // To Check name or Email
    git config --global user.name
    git config --global user.email


    // To Change or Edit name or Email
    git config --global --edit
    // then go to file and edit

    // To see the detail configurations
    git config --list
```
Testing 
Git start

```
    git init            // to initialized
    rm -rf .git         // to remove .git file
```

Git basic commands

```
    ls -a
    git status                          // it tells there are changes that are not currently present in the history of project
                                        // in order to store ,save, tracked files
    git add <fileName>                  // to update what will be committed
    git restore <fileName>              // to discard changes in working directory
    git commit -m "commit message"
    git log                             // to see the histoy of project
    rm -rf <fileName>                   // to delete the file
    git reset <commit_id>               // It will remove all the update or commits of above it
```

Git stash commands

```
    git stash <file>                    // to store files or changes in stage
    git stash pop                       // it will pop out the files from stash
    git stash clear                     // it will clear the file those are not committed are gone permanently
```

Git remote commands

```
    git remote                              // to check all origin URLs
    git remote add origin Github_URL        // to add Url Origin
    git remote remove <origin_name>         // to remove added origin from the folder
    git remote -v                          // it will show all the URL attached to the folder or connected to particular folder
    git remote set-url origin <updated_URL>     // to change URL

    git push -u origin master                  // to push changes to the connection
    git remote rm <nameOfOrigin>                // to delete a remote connection
    git remote rename <oldName> <newName>       // to change connection name


    git pull origin master                    // To revert back the changes from github to local

```

Git checkout

```
    git checkout <fileName>                     // match with last commit file and fit status clean
    git checkout -f                             // matching all previous commit file

    git diff                                    // it will compare working directory to staging area
    git rm --cached <filename>                  // remove from staging area
```

Git branch

```
    git branch                              // to check branches
    git branch -M feature1                      // to create branch
    git checkout feature1                       // to switch branch to feature1
    git merge feature1                          // to merge branch , go to the main branch and merge
    git checkout -b <branchName>
    // delete branch locally
    git branch -d localBranchName

    // delete branch remotely
    git push origin --delete remoteBranchName             // to create and directly switch to that branch

    git log --graph
    git log --all --decorate --oneline --graph     // to get in graph order

    git checkout commit_id  // head pointer to this commit

    git branch -f master <commit_id>        // to refer pointer to that commit

```

Git github commands

```
    git clone Github_URl                          // to clone the project
```

Git starter
`git status`
Three areas

- Working area
- staged area
- repository area

Working area :

- It is not track by git
- untracked files
- there can be a bunch of files that are no currently handled by git.
- It means that changes done or to be done in those files are not managed by git yet.
- a file which is in working area is considered to be not in the staging area, when we do `git status` and we see a bunch of `untracked files`.

Stage Area :

- What all files are going to be part of the next version that will create
- this staging area is the place where git knows what changes will be done from the last version to the next version.

```
    git add <file_name>                     // to add file in stage area that to be commit or create new version
    git add .                                // for all files to stage area
    git rm --cached <fileName>              // to unstaged the file ( for new added file , not for committed file)
```

Repository Area :

- This area actually contains the details of all you previous registered version, and the files in this area.
- git already manages them and knows their version history.
- `commit ` : It is a particular version of the project, it captured a snapshot of the project's staged changes and creates a version out of it.

```
    git commit          // it opens Vim editor to write message -> press "i" to enable to write message , for save :[ escape ->:wq]
    git log             // to see all commits  , to exit log :press -> q
    git restore <fileName>  // it will discard everything that are in stagging area but not committed yet.
    git restore --staged <fileName>    // to unstage the files
    // in already committed file changes are there in working directory

    git add <fileName>          // to add in stagging area
    // the back on the stagging area
    // to get back on working directory   "git restore --staged <fileName>"
```

Between rm and restore

- If we want to move the whole file back to the untracked state .then we do `git rm <fileName>`.
- Otherwise if we just want the changes to be moved in working area or staging area then we `git restore <fileName>`.
- `git diff commit_id1 commit_id2 `

# How internally git works

hashing -> graph/tree data structure

- git is like key value pair
- `key`: hash of the data (security hash algorithm)
- `value`:data
- git uses a cryptographic hash function -> SHA1
- for a given data it outputs 40 digits Hexadecimal number, the hash value is always same for same data.
- after prepared the hash , git compresses the data in a `blob` and stores some meta data about data.
- |blob | <size> |
- |\0 | delimeter |
- |content| |

```
    git init
    ls -a
    tree .git   (structure)
    find .git/objects               // to get details of the objects
    find .git/objects -type f
    echo 'test content' | git hash-object -w --stdin   // to get hash id

    git cat-file -p <hashId>
```

Git Tags

```
    git tag -a v1 -m "tag1"             // to give tag as "tag:v1"

    git show                            // to get tags
    git show v1                         // to get tags
    git push --tags origin master       // to push

```

# GSOC or open source

- fork the repo
- `git clone URL`
- cd folderName
- git checkout -b `branch_name`
- my repo is origin and parent repo is upstream
- `git remote add upstream <URL>`
- `git pull upstream` // to pull the changes or content from upstream
- `git pull upstream <branchName>`

COMMANDS

```
    git clean           // delete untracked files
    git clean -f        // forcefully remove working files
    git clean --dry-run  // would remove file
    git clean -d
    git clean -d --dry-run // it is for remove directories
    git clean -d -f         // it will delete files and folder
    git clean -f           // for files


    git checkout commit_id  // head pointer to this commit
    git log --all --decorate --oneline --graph
```

Log Tech

```
    git log --since="yesterday"         // or "1 minute ago" ......
    git log --grep=comment_name         // to see the specific commit details
    git log --since=10.minute

    git log commit_id^1                 // one parent commit details
    git log commit_id~3                 // to go to grand parents
    ^ (give nth parent)
```

Checkout

- checkout is to move our head point
- `git reset` is of three mode
- 1.soft mode
- 2.mixed mode
- 3.hard mode

Soft Mode

```
    git reset --soft commit_id          // both head,master move to that commit
    git reset ORIG_HEAD                 // it will come back to last commit that you are pointing to .

Note : if you make another commit before this then you will not get back to that previous pointed commit.
    git --no -paper log
    git reset --soft HEAD~2
```

- After moving to a specific ancestor commit if you do a new commit then head is pointing to that commit ,you are not going to point the commit that you are on before moving to previous one
- multiple ORIG_HEAD we can move nad come back

Mixed Mode

- `git reset --mixed HEAD~` (default is mixed)
- it is not just start pointing to the commit recent to but whatever work is there in the staging area,
- it is overwrite the staging area with that commit work.
- `git ls-files `, it will show the all staged files.
- `git ls-files -s`
- git blobOfC2

```
    git checkout blobOdC2

    git reset blobC2
    git reset --hard HEAD~
    git reset --mixed HEAD~             // the content of staging area brought to the working area
```

- 1.moving head and branch pointer
- 2.reset the staging index
- 3.reset the working area

```
    git reset --soft commitId  (a)
    git reset --mixed commitId  (a,b)  // to get commit into staged
    git reset --hard commitId  (a,b,c)  // to get commit into staged and working area


    git revert HEAD
    git --no -paper log
    git revert HEAD~1
```
