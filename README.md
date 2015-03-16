# SCP-Get (scp-get)
Uses WinSCP to allow you to use a directory on a file server as a private software repository.
This is useful when you need to distribute internal software amongst the members of your organization.

## Usage
Before you can use scp-get, you need to make sure that the repository is set-up properly.

### Repository Set-up
The repository directory on the file server should be structured in the following manner:
```
<repository_dir>
  <program_1>.bat
  <program_2>.bat
  <program_3>.bat
  ...
  <program_n>.bat
```
As you can see, the scp-get repository must contain ONLY batch files, and each batch file SHOULD contain the procedures on how to install a program.
The name of the batch files should correspond with the program that it is supposed to install.

### Distributing scp-get
Once you have finished configuring the repository, you will want to distribute the client script (scp-get.bat) amongst your team members.
Before doing so, you might want to pre-configure the scp-get script that you will distribute.

You can pre-configure the following parameters on the script:
* PROTOCOL
  * The protocol to use using WinSCP
  * Default Value: sftp
  * Example Value(s):
    * sftp
    * scp
    * ftp
* SERV
  * The server where the repository is stored on
  * Default Value: None
  * Example Value(s):
    * 10.10.10.10
    * fileshare.domain.com
* PATH
  * The path to the repository directory on the server
  * Default Value: None
  * Example Value(s):
    * /home/user1/scp-get
* USER
  * The username to use when connecting
  * Leave this blank if each person has his/her own account on the fileshare
  * Default Value: None
  * Example Value(s):
    * user1
* PASS
  * The password to use when connecting
  * Leave this blank if each person has his/her own account on the fileshare
  * Default Value: None
  * Example Value(s):
    * p@$$w0Rd

These parameters can be found inside the scp-get.bat file.

### Installing a Program
To install a program from the scp-get repository, simply invoke the scp-get batch script from the command line.

For example, let's say you have a batch installer for Java on your repository.
The procedures of its installation are defined inside java.bat.
To install it, simply enter the following on your command line window:
```
scp-get install java
```
The command above will download java.bat from the repository, and then execute it.
The java.bat file will take care of the actual download and installation of Java.

## Dependencies
* Windows Powershell
* WinSCP
* SFTP/SCP/FTP Server

## Supported Platforms
* Windows

## Author(s)
* Penafiel, John Lawrence M. (penafieljlm)

## Contact
Contact me at penafieljlm@gmail.com for any questions or concerns.
