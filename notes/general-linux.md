# Linux Commands

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/linux/linux-original.svg" width="400" />

## Passwordless SSH

### Homelab (Host)

```shell
ssh -i /C/Users/aomondi/.ssh/id_ed25519_auth aomondi@192.168.100.3
```

### Ubuntu 24.04.3 Server (VM)

```shell
ssh -i /C/Users/aomondi/.ssh/id_ed25519_auth aomondi@192.168.100.4
```

### Mint 22.3 (VM)

```shell
ssh -i /C/Users/aomondi/.ssh/id_ed25519_auth aomondi@192.168.100.15
```

## Secure Copy using SSH (SCP)

```shell
scp -i ~/.ssh/id_ed25519_auth test2.sh aomondi@192.168.100.4:/home/aomondi
```

or

```shell
scp -i /C/Users/aomondi/.ssh/id_ed25519_auth exercise7_installer_for_node_js_npm_with_pid.sh aomondi@192.168.100.15:/home/aomondi/Documents
```

## General Usage Commands

### Get the Hostname

```shell
hostname
```

or

```shell
hostnamectl
```

```shell
### Get Battery Percentage

```shell
upower -i $(upower -e | grep BAT)
```

### Verify SHA256 Checksum (SHA256 Hash)

SHA256 Checksum verification confirms the file has not been corrupted during download.

Creates a sha256 checksum file called **computed.sha256**

```shell
sha256sum <filename.ext> > computed.sha256
```

Example contents of **computed.sha256**:

d91fb5c7a73528c89e0a1aa9a7d959f9deb9ca3dc5211e39bd73fd7df0d9070e  **alpine-virt-3.23.3-x86_64.iso**

```shell
# Steps:
## 1. Get the provided sha256 file content
## 2. Compute the sha256 of the filename.ext specified in the content
## 3. Compare the provided and the computed sha256
## 4. Echo the result
sha256sum -c downloaded.sha256
```

Example output of `sha256sum -c`

```text
alpine-virt-3.23.3-x86_64.iso: OK
```

### Verify OpenPGP Key Fingerprint (GPG Fingerprint)

GPG verification confirms the file actually came from the legitimate source and has not been tampered with by an attacker.

Attempt GPG verification:

```shell
gpg --verify filename.tar.xz.asc filename.tar.xz
```

If you do not have the key, you will get a resposne like:

```text
gpg: Signature made Wed 28 Jan 2026 02:25:38 AM EAT
gpg:                using RSA key 0482D84022F52DF1C4E7CD43293ACD0907D9495A
gpg: Can't check signature: No public key
```

- The long hexadecimal value is the key fingerprint or key ID.
- That is how you discover the key. GPG tells you.

Next, do not blindly fetch the key from a keyserver. The disciplined process is:

1. Go to the official project website.
2. Find the published signing key fingerprint.
3. Compare that fingerprint to what GPG showed you.

Only if they match should you import it.

Download the published signing key fingerprint (a `.asc` file, e.g., `release-key.asc`) and import it:

```shell
gpg --import release-key.asc
```

Compare the GPG fingerprint against the fingerprint shown on the official website.

```shell
gpg --fingerprint
```

Only then verify the signature:

```shell
gpg --verify filename.tar.xz.asc filename.tar.xz
```

An output indicating "**Good signature...**" shows that you are okay, e.g.,

```text
$ gpg --verify alpine-virt-3.23.3-x86_64.iso.asc alpine-virt-3.23.3-x86_64.iso
gpg: Signature made Wed 28 Jan 2026 02:25:38 AM EAT
gpg:                using RSA key 0482D84022F52DF1C4E7CD43293ACD0907D9495A
gpg: Good signature from "Natanael Copa <ncopa@alpinelinux.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0482 D840 22F5 2DF1 C4E7  CD43 293A CD09 07D9 495A
```

The alternative to manually importing the GPG Fingerprint is to download it from a Key Server:

```shell
gpg --keyserver hkps://keys.openpgp.org --recv-keys 0482D84022F52DF1C4E7CD43293ACD0907D9495A
```

## Networking Commands

Check IP address:

```shell
ip addr
```

Check only IPv4 IP address:

```shell
ip -4 addr
```

## Firewall Commands

### View Ports in Use

```shell
netstat -lnpt
```

### Open Firewall Ports in UFW

```shell
sudo ufw allow from any to any port 8083 proto tcp
```

### Confirm Open Firewall Ports

```shell
sudo ufw status numbered
```

---

## Install Docker

```shell
sudo apt update
sudo snap install docker
```

## Install Nexus

We use the original Nexus image from Sonatype here: [https://hub.docker.com/r/sonatype/nexus3/](https://hub.docker.com/r/sonatype/nexus3/)

### Persist Nexus Data

```shell
docker volume create --name nexus-data

docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3

```

### Confirm that Nexus is Running

```shell
netstat -lnpt
```

### Check the Data in the Conatiner

From the Linux server:

```shell
ls -al /var/snap/docker/common/var-lib-docker/volumes/nexus-data/_data
```

```shell
docker exec -it <containerID> /bin/bash
```

then inside the container:

```shell
ls -a /nexus-data/
```
