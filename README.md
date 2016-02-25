Trac on a Debian docker container
=================================


To build the image:

    docker build -t debian-trac [--build-arg TRAC_ROOT=/myproject] .

To run an instance:

    docker run -dtp 8080:80 debian-trac

Access the instance at http://localhost:8080/.

The anonymous user will have full `TRAC_ADMIN` privileges.

Since `tracd` is used to run the Trac instance, no complex authentication
mechanism can be used unfortunately. For basic auth, you might want to run the
instance by using a command line like the following:

    docker run -dtp 8080:80 -v myhtpasswd:/htpasswd debian-trac \
        exec tracd --basic-auth /trac,/htpasswd,Realm -s /trac

`tracd` also supports the `--digest-auth` parameter with a similar syntax.

More complex authentication schemes require Apache or nginx with a WSGI Trac
instance.
