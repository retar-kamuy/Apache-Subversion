# Apache-Subversion

## Create User

```sh
htpasswd -cm /var/svn/passwd admin
New password:
Re-type new password:
Adding password for user admin
```

## Create Repository

```sh
cd /var/svn
svnadmin create repo
chown -R apache.apache /var/svn/repo
```

### Options

`-c` Rewritten the *passwordfile*.

`-m` Use MD5 hashing for passwords.

## Reference

[Simple guide to install SVN on Linux : Apache Subversion](https://linuxtechlab.com/simple-guide-to-install-svn-on-linux-apache-subversion)