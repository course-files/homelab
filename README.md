# Home Lab

## Tech Stack

<p align="left">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/linux/linux-original.svg" width="40"/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/bash/bash-original.svg" width="40"/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/vim/vim-original.svg" width="40"/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/nodejs/nodejs-original-wordmark.svg" width="40"/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/npm/npm-original-wordmark.svg" width="40"/>
</p>

## Repository Structure

```text
.
├── Docker-Compose.yaml
├── LICENSE
├── README.md
├── admin_instructions
│   ├── instructions_for_postlab_cleanup.md
│   ├── instructions_for_project_setup.md
│   └── instructions_for_python_installation.md
├── container-volumes
│   ├── alpine
│   │   └── home-student
│   └── ubuntu
│       └── home-student
│           └── Document
│               └── project_folder
├── devops-by-twn
│   └── 1_os-and-linux-basics
│       ├── exercise-1
│       │   └── exercise1.md
│       ├── exercise-2
│       │   ├── exercise2.md
│       │   └── exercise2_shell_script.sh
│       ├── exercise-3
│       │   ├── exercise3.md
│       │   └── exercise3_ps_aux.sh
│       ├── exercise-4
│       │   ├── exercise4.md
│       │   └── exercise4_ps_aux_sorted.sh
│       ├── exercise-5
│       │   ├── exercise5.md
│       │   └── exercise5_ps_aux_sorted_number.sh
│       ├── exercise-6
│       │   ├── exercise6.md
│       │   └── exercise6_installer_for_node_js_npm.sh
│       ├── exercise-7
│       │   ├── exercise7.md
│       │   └── exercise7_installer_for_node_js_npm_with_pid.sh
│       └── exercise-8
│           ├── exercise8.md
│           └── exercise8_installer_for_node_with_logging.sh
├── docker-compose-dev.yaml
├── docker-compose-prod.yaml
├── dockerfiles
│   ├── Dockerfile.flask-gunicorn-app
│   ├── Dockerfile.nginx
│   ├── alpine
│   │   ├── Dockerfile.alpine
│   │   └── entrypoint.sh
│   └── ubuntu
│       ├── Dockerfile.ubuntu
│       └── entrypoint.sh
├── env.example
├── notes
│   ├── general-docker.md
│   ├── general-linux.md
│   ├── lpic-101
│   │   ├── 101-system-architecture.md
│   │   └── 102-linux-installation-and-package-management.md
│   └── static_ip.md
└── scripts
    └── adduser_if_not_exists.sh

25 directories, 36 files
```

## Setup Instructions

- [Setup Instructions](admin_instructions/instructions_for_project_setup.md)

## Notes

- [Topic 101: System Architecture](notes/lpic-101/101-system-architecture.md)
- [Topic 102: Linux Installation and Package Management](notes/lpic-101/102-linux-installation-and-package-management.md)

## Exercises

### 2 - OS & Linux Basics

- [Exercise 1: Linux Mint Virtual Machine](devops-by-twn/1_os-and-linux-basics/exercise-1/exercise1.md)
- [Exercise 2: Bash Script - Install Java](devops-by-twn/1_os-and-linux-basics/exercise-2/exercise2.md)
- [Exercise 3: Bash Script - User Processes](devops-by-twn/1_os-and-linux-basics/exercise-3/exercise3.md)
- [Exercise 4: Bash Script - User Processes Sorted](devops-by-twn/1_os-and-linux-basics/exercise-4/exercise4.md)
- [Exercise 5: Bash Script - Specific Number of User Processes Sorted](devops-by-twn/1_os-and-linux-basics/exercise-5/exercise5.md)
- [Exercise 6: Bash Script - Start Node App](devops-by-twn/1_os-and-linux-basics/exercise-6/exercise6.md)
- [Exercise 7: Bash Script - Node App Check Status](devops-by-twn/1_os-and-linux-basics/exercise-7/exercise7.md)
- [Exercise 8: Bash Script - Node App with Log Directory](devops-by-twn/1_os-and-linux-basics/exercise-8/exercise8.md)

## Cleanup Instructions (to be done after submitting the lab)

- [Cleanup Instructions](admin_instructions/instructions_for_postlab_cleanup.md)
