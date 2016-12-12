## The WAR File

A WAR file, or **W**eb Application **AR**chive, is a file that essentially represents a
java web application. More specifically, a WAR file is a specific type of JAR file that
is used to deploy various files that make up a Java web application. Such files may include
Java Server Pages, Java Servlets, regular Java classes (POJO), HTML, CSS, JavaScript, etc. These
files have a `.war` extension.

### WAR File Structure

WAR files all abide by a consistent structure:

```
/ (document root)
|
| (.jsp, .html, .css, .js, etc.)
|
|-- /WEB-INF/
    |
    |
    |
    |-- /classes/
    |
    | (.class files)
    |
    |-- /lib/
    |
    | (.jar files)
    |
    |-- web.xml (deployment descriptor)
```

`/ (document root)`

Static files such as HTML, CSS, and JavaScript files are found in the document root. It is completely valid to create additional sub-directories in the document root for further organization (examples: `/js/`, `/css/`, `/img/`, etc.).

`/WEB-INF/classes/`

The compiled Java `.class` files for the web application, including both servlets and non-servlets. Importantly, the Java package directory structure must be preserved within this directory. For example, a Java package of `com.jonfreer`, the `.class` files for that package would reside in `/WEB-INF/classes/com/jonfreer/`.

`/WEB-INF/lib/`

This directory contains all of the `.jar` files that are utilized by the web application, such as third-party libraries or JDBC drivers.

`/WEB_INF/web.xml`

The `web.xml` is known as the _web application deployment descriptor_.

### Creating a WAR File

There are several ways to create WAR files. IDE's and other tools have features to reduce the manual work of creating WAR files, some even being completely automatic. However, these tools are not required.

Regardless of which of these tools you may be using or have access to, one can just use the `jar` command on the command line:

```
jar -cvf filename.war *
```

The option `c` signals that we want to create a new WAR file, the `v` option indicates we want verbose output, and the `f` option is used to specify a file name (in this case, filename.war). Lastly, the `*` means we want to include all files in the current directory in the WAR file.

Here is another slightly altered example, except instead of including all files in the current directory, it only includes all Java `.class` files:

```
jar -cvf filename.war *.class
```

#### Pitfall

A little bit of reading through the Oracle documentation will reveal that the compression used with `jar` is based off of the `ZIP` compression format:

> The jar tool combines multiple files into a single JAR archive file. jar is a general-purpose archiving and compression tool, based on ZIP and the ZLIB compression format.

However, this does **not** mean that you can utilize `zip` and `unzip` commands to create JAR and WAR files. It also does not mean you can use built-in menu compression tools that are displayed when right clicking on files. Even though at first these tools appear to create a WAR file, you will quickly find that when a servlet container explodes the file, it will be in an incorrect format. When using macOS or OS X, for example, the `Compress "filename"` menu option will create a `__MACOSX` folder when unzipping.

#### Using WAR Files with Apache Tomcat 9

Once you have created a WAR file, it comes time to deploy it. A popular servlet container is Apache Tomcat, which is at the time of writing, reached its 9th version. Once Apache Tomcat has been installed, you find amongst its collection of a files and directories a special directory where web applications (WAR files) are deployed. On Ubuntu, this directory can be found at `/var/lib/tomcat8/webapps/`.

To deploy the WAR file to Apache Tomcat, all you have to do is place the WAR file in this directory.

Apache Tomcat is very configurable. Its main configuration file is named `server.xml` and can be found at `/var/lib/tomcat8/conf/` on Ubuntu. Among the various settings that can be specified, there exists a `<Host>` node. The `appBase` attribute specifies the name of the directory to hold web applications. The `unpackWARs` attribute is a setting that allows Apache Tomcat to explode, or extract the files from the WAR file after deployment. Lastly, the `autoDeploy` attribute provides the ability to deploy WAR files after Apache Tomcat has been started.

```xml
<Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">

<!-- more settings... -->

</Host>
```

### Resources

- http://docs.oracle.com/javaee/5/tutorial/doc/bnadx.html
- https://web.archive.org/web/20120626020019/http://java.sun.com/j2ee/tutorial/1_3-fcs/doc/WCC3.html
- https://en.wikipedia.org/wiki/WAR_(file_format)
- https://tomcat.apache.org/tomcat-6.0-doc/config/host.html
