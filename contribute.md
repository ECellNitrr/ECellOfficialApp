# Steps involved in Open Source Contribution

Here I will explain the various steps involved in making a successful open source contribution.

* Forking the repository:
    - This is the first important step, which consists of making a copy of the repository on our GitHub account.
    - It is done by opening the target repository, clicking on the fork button, and then clicking Ok.

* Cloning the repository:
    - In this step, we clone the forked repository on our local machines to make changes in the forked repository.
    - It is done by copying the link that appears after clicking the code button of the forked repository page.
        ```markdown
        git clone <copied link>
        ```
* Creating a new branch:
    - In this step, we create a new branch.
    - The following command is used to do this:
        ```markdown
        git checkout -b <branch name>
        ```
* Pulling the changes:
    - In this step, we pull changes in our repository to keep the repository in sync with the changes.
    - The following command is used to do this:
        ```markdown
        git pull origin <branch name>
        ```

* Making the necessary changes:
    - In this step, we make the required changes in the repository.
    - It is performed on the cloned repo that is on our local system.

* Committing and pushing the changes:
    - In this step, we commit and push the changes to our branch.
    - The following command is used to do this:
        ```markdown
        git add .
        git commit -m "Commit Message."
        git push origin <branch name>
        ```
   -    The commit message should mention the purpose of the commit.

* Creating Pull request from the forked repository:
    - In this step, we create a pull request so that the changes we made can be reviewed and merged to the original repository.
    - It is done by clicking on the New pull request button at the top of the repository page.
    - To describe the goal of the PR, we must give it a short, simple name.

* Finally, the admins examine the pull request, and if the changes made are correct, it is accepted and merged to the original repository.