# Exercise 3: Bash Script - User Processes

## Question

Write a bash script using Vim editor that checks all the processes running for the current user (`USER env var`) and prints out the processes in console. Hint: use `ps aux` command and `grep` for the user.

## Answers

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/bash/bash-original.svg" width="400" alt="Bash Logo"/>

- Step 1: Create the Bash Script using Vim

    ![Create using Vim](assets/images/1.png)

    Add Content to Script using Vim:
    ![Add Content to Script using Vim](assets/images/2.png)

    Link to bash script: [exercise3_ps_aux.sh](exercise3_ps_aux.sh)

- Step 2: Set the required permissions to execute the script

    ![Set the Required Permissions](assets/images/3.png)

- Step 3: Execute the script

    Executed using:

    ```shell
    sudo su
    ./exercise3_ps_aux.sh
    ```

    ![Execute the script - input](assets/images/4.png)

    ![Execute the script - output](assets/images/5.png)
