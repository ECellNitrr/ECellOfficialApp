# Steps involved in Open Source Contribution
Here I will explain the various steps involved to make a successful open source contribution.

## Steps are :
* Forking the repository:
    - This is the first important step in which we make the copy of the repository on our github account.
    - It can be done by opening the target repository and clicking on the fork button and then clicking Ok.

* Cloning the repository:
    - In this step we clone the forked repository on our local machines so as to make changes in the repo.
    - It can be done by copying the link that appears after clicking the code button of the forked repository page.
        ```markdown
        git clone <copied link>
        ```
* Creating a new branch:
    - In this step we create a new branch.
    - It can be done by the following command:
        ```markdown
        git checkout -b <branch name>
        ```
* Pulling the changes:
    - In this step we pull changes in our repository so as to keep the repository in sync with the changes.
    - It can be done by following command:
        ```markdown
        git pull origin <branch name>
        ```

* Making the necessary changes:
    - In this step we make the change that we intend to do in the repository.
    - It is performed on the cloned repo that is on our local system.

* Comitting and pushing the changes:
    - In this step we commit and push the changes to our branch.
    - It can be done by the following command:
        ```markdown
        git add .
        git commit -m "Commit Message"
        git push origin <branch name>
        ```

* Creating Pull request from forked repository:
    - In this step we create a pull request so that the changes we made can be reviewed and merged to the original repository.
    - It can be done by clicking on the New pull request button on the top of the repository page.

* Finally the pull request is reviewed by the admins and if the changes made are correct, it is accepted and merged to the original repository.


