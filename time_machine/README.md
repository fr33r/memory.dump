### Linux Time Machine

I wanted to have my Linux server act as Time Machine for my Apple devices.
Here are the various steps I took to successfully achieve this setup.

#### Netatalk

One of the necessary applications needed on my Linux server in order to
achieve my desired setup is [Netatalk](http://netatalk.sourceforge.net/wiki/index.php/FAQ#What_is_Netatalk_for.3F_What_can_I_do_with_it.3F).
In short, Netatalk is an open source AFP 3.1 compliant file-server.

##### Installation

Netatalk hosts their own [Wiki](http://netatalk.sourceforge.net/wiki/index.php/Main_Page)
that provides a wealth of information, including installation instructions.
My Linux machine is running Ubuntu Xenial, so I followed [these instructions](http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.11_on_Ubuntu_16.04_Xenial)
get my Time Machine up and running.

To help automate the process, I created a super simple [bash script]() to execute
all of the commands outlined on Netatalk's Ubuntu Xenial installation instructions.
If you also are using Linux Xenial, feel free to give this script a whirl. Otherwise,
check Netatalk's Wiki for installation steps for your setup.

##### MacOS Configuration

I followed this [blog article](https://samuelhewitt.com/blog/2015-09-12-debian-linux-server-mac-os-time-machine-backups-how-to)
to ensure that I made the appropriate configuration within my `/usr/local/etc/afp.conf`.

