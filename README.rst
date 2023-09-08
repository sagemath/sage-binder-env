A Binder repo for SageMath computing environment
================================================

This repository is a Binder repo based on `SageMath <http://sagemath.org>`_. To
access a computing environment created by `Binder <http://mybinder.org>`_ using
SageMath kernel, click on this badge

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/kwankyu/sage-binder-env/master


An example Binder repo for SageMath
-----------------------------------

Have a repository full of Jupyter notebooks using SageMath? It's easy to setup
Binder to let anyone run them. Just fork this repo, put your notebooks in the
`notebooks` directory.  and modify this `README.rst` to your needs. In
particular, you probably want to modify this line::

:target: https://mybinder.org/v2/gh/...

with `...` filled with the name of your forked repo. This makes the Binder badge use your
repo to create the Jupyter computing environment.


Extending the Dockerfile
------------------------

The `Dockerfile` builds Sage with base Docker image::

    FROM ghcr.io/sagemath/sage/sage-ubuntu-focal-standard-with-targets-optional:dev

which contains Sage built in the current develop branch.

It includes Sage itself, and all the software packages typically
included in a standard Sage installation, though not *everything*. In
particular not optional Sage SPKGs, or other system software packages.

So in order to install additional Sage SPKGs, include a line like::

    RUN sage -i <spkg-name>

in the `Dockerfile`.


Authors
-------

Nicolas M. Thiéry, E. Madison Bray, and Kwankyu Lee
