# LogAnalysisProject

# Installing the Vagrant VM

We're using the Vagrant software to configure and manage the VM. Here are the tools you'll need to install to get it running:

### Git

If you don't already have Git installed, [download Git from git-scm.com.](http://git-scm.com/downloads) Install the version for your operating system.

On Windows, Git will provide you with a Unix-style terminal and shell (Git Bash).  
(On Mac or Linux systems you can use the regular terminal program.)


### VirtualBox

VirtualBox is the software that actually runs the VM. [You can download it from virtualbox.org, here.](https://www.virtualbox.org/wiki/Downloads)  Install the *platform package* for your operating system.  You do not need the extension pack or the SDK. You do not need to launch VirtualBox after installing it.

**Ubuntu 14.04 Note:** If you are running Ubuntu 14.04, install VirtualBox using the Ubuntu Software Center, not the virtualbox.org web site. Due to a [reported bug](http://ubuntuforums.org/showthread.php?t=2227131), installing VirtualBox from the site may uninstall other software you need.

### Vagrant

Vagrant is the software that configures the VM and lets you share files between your host computer and the VM's filesystem.  [You can download it from vagrantup.com.](https://www.vagrantup.com/downloads) Install the version for your operating system.

**Windows Note:** The Installer may ask you to grant network permissions to Vagrant or make a firewall exception. Be sure to allow this.

## Fetch the Source Code and VM Configuration

**Windows:** Use the Git Bash program (installed with Git) to get a Unix-style terminal.  
**Other systems:** Use your favorite terminal program.

From the terminal, run:

    git clone https://github.com/Rizialdi/LogAnalysisProject

This will give you a directory named **LogAnalysisProject** complete with the source code for the python file, a sqlfile, a readme file for description and a vagrantfile for installing all of the necessary tools. 
At this point you need to [download newsdata.sql file](https://d17h27t6h515a5.cloudfront.net/topher/2016/August/57b5f748_newsdata/newsdata.zip), unzip it and put it on
the directory named LogAnalysisProject.

Snapshot of newsdata.sql:

![](https://i.imgur.com/3Mj66NQ.png)


## Run the virtual machine!

Using the terminal, change directory to LogAnalysisProject (**cd LogAnalysisProject**), then type **vagrant up** to launch your virtual machine.


## Running the LogAnalysisProject
Once it is up and running, type **vagrant ssh**. This will log your terminal into the virtual machine, and you'll get a Linux shell prompt. When you want to log out, type **exit** at the shell prompt.  To turn the virtual machine off (without deleting anything), type **vagrant halt**. If you do this, you'll need to run **vagrant up** again before you can log into it.


Now that you have Vagrant up and running type **vagrant ssh** to log into your VM.  change to the /vagrant directory by typing **cd /vagrant**. This will take you to the shared folder between your virtual machine and host machine.

Type **ls** to ensure that you are inside the directory that contains newsdata.py, newsdata.sql, useful.sql, a vagrantfile and readme

Now type **psql -d news -f newsdata.sql** to initialize the database and fill it up.
Now type **psql -d news -f useful.sql** to create the functions and the views.
Now type **python newsdata.py** to get results.

![](https://i.imgur.com/UnDod5E.png)

You get a well formatted output of the necessary informations

