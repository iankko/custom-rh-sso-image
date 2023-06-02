# An example of custom "RH-SSO 7.6.3.GA" UBI8 Minimal Based Container Image

This repository contains a definition of a simplified / demo container image,
based on the Red Hat Universal Base 8 Minimal image, utilizing the RH-SSO 7.6.3.GA
server distribution ZIP artifact, expected to be built using the [CEKit](https://cekit.io/) tool.

The image already defines two CEKit modules:
1. The `add.jboss.user` one, which adds a `jboss` user (UID 185) to the image,
2. The `install.rh.sso.zip` module, which extracts the RH-SSO 7.6.3.GA server
   distribution Zip archive (using `/opt/sso/rh-sso-7.6` as `JBOSS_HOME`)

## Building the Image

You can build the image using the following command:
```
$ cekit --descriptor image.yaml build docker
```

Note: Ensure the `docker` service is running on your host.

## Running the image

You can run the image as follows:
```
$ docker run -it --network=host custom-rh-sso-763-openshift-ubi8-image:7.6.3.GA-1
```

Once the image has started, navigate the browser to `http://localhost:8080/auth`
and create RH-SSO administrator user. Then click the `Administration Console`
link and specify RH-SSO admin user credentials to login.

## Homework

Please create a (full) definition of a new `check.opt.sso.modules.perms` CEKit
module, which will check if the permissions of the '/opt/sso/rh-sso-7.6/modules'
directory are correct in the sense, the user running the container image is able
to create a new directory (a module definition) under the '/opt/sso/rh-sso-7.6/modules'
path.

The way you use for checking the permissions to create new subdirectories under the
```${JOBSS\_HOME}/modules``` directory is left up to you (you can either check permissions
of that directory directly, or try to create a subdirectory under ```${JBOSS\_HOME}/modules```,
etc.).

The expected output of the 3rd module implementation being:
* The image will print nothing (continue starting properly) if permissions of ```${JBOSS\_HOME}/modules```
  are OK (user running the image is able to create a new subdirectory under modules/),
* The image will refuse to start and print an error message about permissions of ```${JBOSS_HOME}/modules```
  directory not allowing to define custom modules in the case permissions are insufficient / incorrect.

Hint: To test proper work of your implementation, comment out the:

```
chown -R jboss:root "${JBOSS\_HOME}"
```

statement on line #5 of the ```modules/install/rh/sso/zip/install_rh_sso_zip.sh``` script, followed by
rebuilding & rerunning the image again. When that line is commented out, the image should refuse to
start with the error message specified in your implementation of the `check.opt.sso.modules.perms` module.
